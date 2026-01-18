Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64123315A;
	Sun, 18 Jan 2026 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768759392; cv=none; b=VU01aZvp7QSNXawhkjHAJRpe1A519TjfKmpXnJZJJX+ld/CnibBUcmIrXUaTOeZ1Z3iOMIslZYjuLrX2RGzNzSlF/w99vHICsIEj1yOuPFPF2o9NwUP7qqZlRYBeaQKjJ1jGGN83iLbUs7y2a7fqOKc/qqZfc5ZFLLl+PD4Haq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768759392; c=relaxed/simple;
	bh=I6FIvpCZnqc0+Nxtus5G/drPLTTVOCDnzupWLi+vC60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZD5ZK7sakfGswFpvSqQhMK9YMBzZ5QlnOC7UBlFYUmICPxTK5EhzmGBql1F9i8x5YPCi1HxzqFIDEkKL7bTZsqd4LdfGEKwiSZSa4Lqx+mEo3VjMxmU6aSHnOY8jcL+w56ErtPJ+9dU578HwkIeKFqZdvzQ9dYlrvfJ15nQAAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP7NIgjK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP7NIgjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148C0C2BC9E;
	Sun, 18 Jan 2026 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768759392;
	bh=I6FIvpCZnqc0+Nxtus5G/drPLTTVOCDnzupWLi+vC60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OP7NIgjKh+KigUkX5vwOsPfqukrM173PzOHmo+HcScObB99mbsPJy4/Q63zTPu+ul
	 UdGSUUGj4RRgbR8c16U+gYmMnboSaKZD/4RSgRZE2IvwVy+1WJCoEklePTi+2K+gxz
	 WGRcJPniDM3Or431A3vO7RsPETKXfKWzAHDlrx9zxLIhCavp9itljcAN7844OrRGGr
	 dHc2FQa9BFjhioAvYIYThHgwr0DIMVbS8Lnl3NPnI5aQfWfDt7SZBbnOgJNJkC4gsw
	 vZr/7yzJc2/weeb0LFWqRzMjGvi7hYxcnvazpZVO/uOrUsxRJ3wjDo+6/rn/z8h6yt
	 8sf2r77Cgk1bw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/8] Docs/mm/damon/design: link repology instead of Fedora package
Date: Sun, 18 Jan 2026 10:02:53 -0800
Message-ID: <20260118180305.70023-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260118180305.70023-1-sj@kernel.org>
References: <20260118180305.70023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The document is introducing Fedora as one way to get DAMON user-space
tool (damo) from OS-providing packaging system.  Linux distros more than
Fedora are providing damo with their packaging systems, though.  Replace
the Fedora part with the repology.org page that shows damo packaging
status for multiple Linux distros.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 0cfd4c25e92d..f3db943d7efc 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -809,8 +809,8 @@ The ABIs are designed to be used for user space applications development,
 rather than human beings' fingers.  Human users are recommended to use such
 user space tools.  One such Python-written user space tool is available at
 Github (https://github.com/damonitor/damo), Pypi
-(https://pypistats.org/packages/damo), and Fedora
-(https://packages.fedoraproject.org/pkgs/python-damo/damo/).
+(https://pypistats.org/packages/damo), and multiple distros
+(https://repology.org/project/damo/versions).
 
 Currently, one module for this type, namely 'DAMON sysfs interface' is
 available.  Please refer to the ABI :ref:`doc <sysfs_interface>` for details of
-- 
2.47.3
