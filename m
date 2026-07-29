Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE84C6F15;
	Wed, 29 Jul 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333789; cv=none; b=AloIb+b5DDH55mTykxcEs109O1v45eUIldCMyoI58TQC+cShP4VQGdMmNtIPdoPkFCq1VV4FOhX0x8kDDp+28z0oY6sTbsAZ0vm/hlZxFmc0dFKE34JzaiEX54+WBUjwQ3Vs0bZ7CZf8pVaPyEQP+UB/9RpROs0jWGDc+eMng7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333789; c=relaxed/simple;
	bh=2xY8XmsQ169rflgljcAafurgWq/upAZgTuMMbRiXQh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArzWQ8KlHxUiVA0o4kMxTe04Z7d96m1mIikd7m88JGrikI8NzH6JE4/DsWc0GD9RbZVxpoukRE5jFs9MkewE3lSIvikoPYkofaj/kLIy0/ufjcILt4q2h03HuDnEeoiRA39DzkVApaa2c8ziEaTHaJ+SPq3xgTwmfUtHaj8XKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCY6Kfg6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCY6Kfg6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F1A1F00A3A;
	Wed, 29 Jul 2026 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333788;
	bh=FTkFqCNT/LseVbtXKhwVw4AevH2QQucXk6b0DrI2IK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jCY6Kfg642m2C60vKXHAEOQbfP3Q7OEL3PytJIvUfzVav4TeZK0BLDzrUxKpCqG1F
	 rgoOFzBmm7fC05ocsXZIn1dxxC2FXThNytvprMuHEl342oOWdTlaJF4BGEdqapiX5o
	 SOHmztScUESE4PgfrqDQt5qNpv74YiA1Sk+PUn/0CFEmsIOl79YLA8iVsMNQJTtWYp
	 XQrbmdKG5xKGCIfQQ3pU47vs5o1BIs2cDg7Jl6QJLhl9tKc8FhuOMcYnFnAihNzg3u
	 f/6cby8AyfLNZ0tkj0txM/SACn9t5cvTMsIL4q8ZNpgXCSvpYXR6RuPAMQG4mxKRGO
	 5rROm/vfqtG4Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 12/12] Docs/ABI/damon: recommend subsystem doc instead of admin-guide
Date: Wed, 29 Jul 2026 07:02:52 -0700
Message-ID: <20260729140253.87753-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729140253.87753-1-sj@kernel.org>
References: <20260729140253.87753-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON ABI doc is recommending DAMON admin-guide for people who are
willing to know further about DAMON.  Nowadays the subsystem doc
(Documentation/mm/damon) is a more recommended place for even beginners.
Recommend the subsystem doc over admin-guide.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index f8d2601e82904..ad21f58f3c912 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -3,7 +3,7 @@ Date:		Mar 2022
 Contact:	SJ Park <sj@kernel.org>
 Description:	Interface for Data Access MONitoring (DAMON).  Contains files
 		for controlling DAMON.  For more details on DAMON itself,
-		please refer to Documentation/admin-guide/mm/damon/index.rst.
+		please refer to Documentation/mm/damon/index.rst.
 
 What:		/sys/kernel/mm/damon/admin/
 Date:		Mar 2022
-- 
2.47.3
