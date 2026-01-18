Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D16301493;
	Sun, 18 Jan 2026 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768759394; cv=none; b=YFHFJTm+6bHAfF4NM4BT/YiPrMAwG6O2ApWM7vW5XcDqCqz8kQWoXgLLUT58hpkGl2ORAJMQTtpAkM6EcJnZ+psqoYmRWr4S84IPMtQyg7cm09p+DsRkavnkjSEzVImGOZ5oCMLOLSslP9H2xXZUHZBOQlpZy1+g12H9v00ApCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768759394; c=relaxed/simple;
	bh=1GRiXmsO65OYbfT1UpFoUJRXTsmQCXqwNCyc2P2HEi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+tEC1nkgtrZha4XjdQwrntTM+/qqMBmtI29It0bVp0F/+gzZDBgSoBq/qmuD3kR4QGd9agQT/PO5kKZkrVtN2gBbp+tlM9hywkiwVGdepam6USnWH+F9jAaxhc/SPFRMGDhKjCe92uX9XhtdBuGbcc/T+P34AUIfX+kCYGbTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewvwYXCI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewvwYXCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E206DC116D0;
	Sun, 18 Jan 2026 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768759394;
	bh=1GRiXmsO65OYbfT1UpFoUJRXTsmQCXqwNCyc2P2HEi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewvwYXCI0UNZ/JjJAkjbGBLsGZjO414jRL6prWYBB8Pa9s8HysdJrNQwhL73sx3m+
	 ysed0jEyD+/qkThI/MhqbaYOJlR28ZO0SD7VRrSvI4GFwnmAeG3rpYRlC3pvkcwX3h
	 F9KY8x5EhL8yyGCX7ijt3lrQGQI0w/PwVN7E0Cvm2iYuKwejd2T7S+g3WAcyb7jpom
	 ZgLvgKbkLXd2T6QMNUJqbQL1sHS29cpaVjhMZA/dIfLn4l5D2eiwlh3CIdOc9hEv/0
	 n77vsWspqZaYxIl1CslTUChb6B4H7iAtHjF+oAbb7fMIU3L+smo2M7GMC8K4sCU1vj
	 d89MLT1AsQE8g==
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
Subject: [PATCH 7/8] Docs/mm/damon/maintainer-profile: fix wrong MAITNAINERS section name
Date: Sun, 18 Jan 2026 10:02:58 -0800
Message-ID: <20260118180305.70023-8-sj@kernel.org>
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

Commit 9044cbe50a70 ("MAINTAINERS: rename DAMON section") renamed the
section for DAMON from "DATA ACCESS MONITOR" to "DAMON".  But the commit
forgot updating the name on the maintainer-profile document.  Update.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index e761edada1e9..4fa06b21ec30 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -3,8 +3,8 @@
 DAMON Maintainer Entry Profile
 ==============================
 
-The DAMON subsystem covers the files that are listed in 'DATA ACCESS MONITOR'
-section of 'MAINTAINERS' file.
+The DAMON subsystem covers the files that are listed in 'DAMON' section of
+'MAINTAINERS' file.
 
 The mailing lists for the subsystem are damon@lists.linux.dev and
 linux-mm@kvack.org.  Patches should be made against the `mm-new tree
-- 
2.47.3
