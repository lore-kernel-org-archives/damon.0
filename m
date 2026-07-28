Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CEE3B4EBC;
	Tue, 28 Jul 2026 05:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216501; cv=none; b=gjBZbVeQV182IW0Rn5bXagd8ldmQOWX9XEpbNZKup1pT04bO3F3sNfPubw5MeUSimuv95W7B3UWDozel/PAGiVPlHbIrQIxOMGI2z4sib9idGqBbL9gA1LZ/degK0/xaUDf0q49iZRYCsYpJe/huIsZ3DQne4wCYO62QlQvxyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216501; c=relaxed/simple;
	bh=2xY8XmsQ169rflgljcAafurgWq/upAZgTuMMbRiXQh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYblMZhYVawq/AjjhPnQPTWPHQ4MiM9C6kUofbsrq74p5PKPbKXN8KjaHu89bLz8KKWjoiVJWNsAeMd1cVwsiLKzExCIlaIzOvyEHM2ZojgGyR+/kuGec57Z8ASeK9nNcLb3tT5/MyL3ZbAgkK/yAG3Eu1p/l25l9sv9Po8QdAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D79Wl+u+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D79Wl+u+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5931F00ACF;
	Tue, 28 Jul 2026 05:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216500;
	bh=FTkFqCNT/LseVbtXKhwVw4AevH2QQucXk6b0DrI2IK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D79Wl+u+H5GZQ89D0Yq2/pD/Qra22nMMYXqRknbyYwIsEbcCD7WW9xAg9oxwd88An
	 xV8DXBGQwXek7sdNI1+/P2r+TOL80aLQoH7SjT2wad84L4HKAH3XHP3dv6H0bA3Fa9
	 FGT6iScfI62Nx3Y1Y/zfRix9/U6Ec/IJSwpyI56y0Vi9japCqQGGwqfXC0gUiuXASz
	 WNYRNlCmVhdTrim+l9CXH8b9n2BOG9fpWHjdI92kMGywSELOcaj6TArv6jmfM4Vq4q
	 0oeuRzl4Fy1qe88mMbEnpyJnNcq6g2sdBegU0Ds7q/99Crkz7QYJeJQQ500YldL1Gk
	 f72SYsmBGR+Qw==
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
Subject: [RFC PATCH 10/10] Docs/ABI/damon: recommend subsystem doc instead of admin-guide
Date: Mon, 27 Jul 2026 22:28:09 -0700
Message-ID: <20260728052811.192712-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728052811.192712-1-sj@kernel.org>
References: <20260728052811.192712-1-sj@kernel.org>
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
