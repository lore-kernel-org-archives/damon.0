Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2D267701;
	Thu, 20 Feb 2025 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080125; cv=none; b=N1CDw/wTCxZtQEJ4VY+ighqNhkZoHl2jPTTLM+5aGOuvl6ECkxX0cGyUWrnbHFrGl+aVWcKnqXDAe0VUwChmqeLco+WLxa4WHG73LVAkaAllxIOMls1pvVFuNHlS3OKi+UD/p3FPHajeOwWlYkXRYvl1s9/OG4MxR0nW7Sg0mu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080125; c=relaxed/simple;
	bh=lQdCqJbuwqzMBVYn0ePijMi74LmE9XAyvz+DAnJaquU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HfResUF2HttGs+BT+3QLa6LlWEsJoz9mm8yiBHR3gfBqfrUsZkhZlV1m+XMWB7SAxBW7xLvW3zULEFtyqEwAzaG5ufM1IPPm1t0zIMRImKAtxMQBrYJE5YZWEuazjbd6BphXWoZE+MGiEqxOnvmcKmSr/Bwa8oB8FgtGxD+4rxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZMn6WIf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZMn6WIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C770C4CEE3;
	Thu, 20 Feb 2025 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080124;
	bh=lQdCqJbuwqzMBVYn0ePijMi74LmE9XAyvz+DAnJaquU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZMn6WIfr5nauFmmgrz27Rv8ZIKr5SlSx8s7NX/PPfmgJddMM8/RNUto4mOB1ikpp
	 ZjF7ftkm3gAQmuKQB1sy7Tlgv6ly1qucgN/eFu41DhJqEsZhOMRblCa4pwW9YOGMem
	 S//I3/DSBbf7K7M7Hmc9g/y9knPfmydm8XSjjMqeshFfNIbCZWTZNSvwK1HPqAxTMI
	 a98o7ltCQzyGP3Evev31R9bhsZOIBEyxKEINraDRcRauklbw+mXrX48lR8pUNmJMUl
	 DcHKTvegIS6NghmMM5//LAkaslX+buIwZAzNhOp/wbYLfE5EBbzF6PkIqJS0JMuB5l
	 LQ5YLrVkvdPUQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 9/9] Docs/mm/damon/design: update for changed filter-default behavior
Date: Thu, 20 Feb 2025 11:35:09 -0800
Message-Id: <20250220193509.36379-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220193509.36379-1-sj@kernel.org>
References: <20250220193509.36379-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters evaluation stages' default behaviors were always allowing
before.  But the previous commits have changed the behavior to be
decided by installed filters.  Update the documentation to clearly
describe it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 5af991551a86..ffea744e4889 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -581,9 +581,10 @@ When multiple filters are installed, the group of filters that handled by the
 core layer are evaluated first.  After that, the group of filters that handled
 by the operations layer are evaluated.  Filters in each of the groups are
 evaluated in the installed order.  If a part of memory is matched to one of the
-filter, next filters are ignored.  If the memory passes through the filters
+filter, next filters are ignored.  If the part passes through the filters
 evaluation stage because it is not matched to any of the filters, applying the
-scheme's action to it is allowed, same to the behavior when no filter exists.
+scheme's action to it depends on the last filter's allowance type.  If the last
+filter was for allowing, the part of memory will be rejected, and vice versa.
 
 For example, let's assume 1) a filter for allowing anonymous pages and 2)
 another filter for rejecting young pages are installed in the order.  If a page
@@ -595,11 +596,6 @@ second reject-filter blocks it.  If the page is neither anonymous nor young,
 the page will pass through the filters evaluation stage since there is no
 matching filter, and the action will be applied to the page.
 
-Note that the action can equally be applied to memory that either explicitly
-filter-allowed or filters evaluation stage passed.  It means that installing
-allow-filters at the end of the list makes no practical change but only
-filters-checking overhead.
-
 Below ``type`` of filters are currently supported.
 
 - Core layer handled
-- 
2.39.5
