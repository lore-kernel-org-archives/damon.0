Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114B4346787;
	Wed, 12 Nov 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962166; cv=none; b=iNyNxv93RUNN15ivd5faaQfeDy4QfbXsloKS0bRrQLNDvEU1iB+PTCubCmqGoS4C7SsMcT5Csl7OkPyCLOqAoQlJ6ZUPL+0nEC3+hpdUd57ahOmLM0UNbYRRHaWLiAohhI9M1ddRwrUlPT5TGHUA1oAj+Qno1zfQo36WQMNXN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962166; c=relaxed/simple;
	bh=+Y8/mmzsL4R1VnXUesO/LqQSUharTVlUfdkKQD15AOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opT78QisxVrtuW4woLdaFyOR5xma+R9tAg3hjICuE2yAnJCGtjR1bZn27DqIjIul8cOs3aVcx0/oUbpzS/KKkP4BjVyzvSIufK86h3miqvc3xRLvJiyqWw6P5h85xFlt+h/6IYCZMyIwEXm/ARrENFHwugZ1j7+d/ObrHTWXdzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPxNTBtu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPxNTBtu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EE4C19421;
	Wed, 12 Nov 2025 15:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762962165;
	bh=+Y8/mmzsL4R1VnXUesO/LqQSUharTVlUfdkKQD15AOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VPxNTBtuFzWP5E0kbJfUaoHse2TRa2w3nZ7fygR+O4btmVa4UyrFKKPFIVhBu1gAp
	 /FxcP+pNURKfWiadsKxQsW+cuQkIE/ik57NaUnCq2om4A6XN+9Ev2fZEbRPl/saqy1
	 1FAPq3L/MS8HBKtkCko/vb381RHwcFxRcnYu5clqp4frD5Mt9zBWEibZI+OOpbRNbP
	 cQfXVgDHOBs+XzBzlIYZcLlZB4gv1NkonecWttOx4sE5fIOLC3ztqIX76Bg6p7aJ/F
	 UyGuKTdsWUkuCq53Vhruu08ckKwqpZWi//L+HpgnQAl0Z9CErM3dHFWNwKJqxnanBt
	 6+pGTk/lNP2ew==
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
Subject: [PATCH 8/9] Docs/mm/damon/maintainer-profile: fix a typo on mm-untable link
Date: Wed, 12 Nov 2025 07:41:11 -0800
Message-ID: <20251112154114.66053-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112154114.66053-1-sj@kernel.org>
References: <20251112154114.66053-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0b473f9e6eac ("Docs/mm/damon/maintainer-profile: update for
mm-new tree") mistakenly forgot putting a space between a link and the
next word.  Fix it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index 58a3fb3c5762..f1aed6e55d31 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -57,7 +57,7 @@ Key cycle dates
 
 Patches can be sent anytime.  Key cycle dates of the `mm-new
 <https://git.kernel.org/akpm/mm/h/mm-new>`_, `mm-unstable
-<https://git.kernel.org/akpm/mm/h/mm-unstable>`_and `mm-stable
+<https://git.kernel.org/akpm/mm/h/mm-unstable>`_ and `mm-stable
 <https://git.kernel.org/akpm/mm/h/mm-stable>`_ trees depend on the memory
 management subsystem maintainer.
 
-- 
2.47.3
