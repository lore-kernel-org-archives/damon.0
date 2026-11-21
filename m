Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795289622;
	b=dFUEc2eVm84IRYzdBVGAMc3YOV+t0BVHwLEQ2JeRBBDrhFgLbteJmm0J9PGcMG2kLQSX
	 1JTCeZevMwVTEJ7EFP1737tq4nbzhtY/tDZthUo1GFupnATnm+CiA9PqClDLUD2gW0rI6
	 sl7OpOrzMlrVosaTocZ3YDnu/qsERJ8nfh2fO4L8WHgEM7wG6pNE+SneLOc/vIYtPvCUG
	 6WOEVCtqP2d9ghYEOWJ5cTtkRayoA3/8hu6+rCY5VfnYE9IdO8ao/vEShxiP4RqRHIqe9
	 vUfHbCgtAECfX3wh3Owt7qhWvOVJILtPyNmcfK/SIy5QyCyLc5xWgJ3ljcVdnN0ugNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795289622;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oipHQJlQVylrVPx8RtKqcrMUGU679rocneT4MdJfejo=;
	b=L2wxMU3Hgb3JWmPaySVxUtJSFlBm8K0AHUtm8cGDyt/qrzdV5EmMiZ5s49HHGryUxfCf
	 YaTrhqjwD2B4A1dp6zml/WPhLh7LzxSjhZ+K6IHq9wMv/FE+5BZbe/L7mxa8NIeic5oJV
	 Hn0h8Cuzsr+wMU9Dq0RgvxSXf8w8JvG16hXI7w6Q6PVGd+tt0UWcsI0nlYHqOi6qcI2CB
	 NF8L2TLaWmJTgeCY6aFVPOAv+wwXwKanFbjKDMos8onPRzc6h9hE8KftBjCsMblTWGB6+
	 zFSKYCWz4zI2AypgLueOAqVOqRrvZ+X16ex4SW6gbmCFyq0u1J23GrvUT/JCZYl6NSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpmIHZYY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384C606A338;
	Sat, 21 Nov 2026 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpmIHZYY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9E31F000D0;
	Sat, 21 Nov 2026 19:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795289622;
	bh=oipHQJlQVylrVPx8RtKqcrMUGU679rocneT4MdJfejo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QpmIHZYY/BPHc5mWi64zEvMbT6qYIry+GMQU2MGP0y8g71vrmVZ4jtWwn78lhyV27
	 jdbejCHx9sS+de+zXjvM8sBVyuK2IvgXYfPisudagT0hnhW6gxohFb14Ixrqh3vhlP
	 gVYZ+6j9r53ZGBg0Za2LTTMNevnq8Y81O0KAF2jc41h9zuzz/3i//40QdEtdH7hDoj
	 ejOs1c5k9VCXu6Z7FjUURuxf8AsGM7CZm+BL7733xprp/KpTYA7AYp0MjynRQC33Nv
	 WRMZ7KbTHMoqHVlX9RanLrineoeAPNrmEi6KhTD6VascSXC2dzhR6/aVXGHEcmB21P
	 oMPdCO4G73gfA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/4] Docs/mm/damon/maintainer-profile: use damon.git for patch baselines
Date: Sat, 21 Nov 2026 11:33:27 -0800
Message-ID: <20261121193331.108587-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121193331.108587-1-sj@kernel.org>
References: <20261121193331.108587-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right after 7.5-rc1, DAMON will onboard the mm-next transition [1].
Update DAMON maintainer-profile document to suggest using damon.git [2]
for-next and for-next-fixes trees as baselines, following the mm-next
process guideline.

[1] https://lore.kernel.org/bed81e01-7303-4957-bd7d-38e3a094e96f@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mm/damon.git/

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index c482690320249..cc6b79c066a64 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -3,13 +3,20 @@
 DAMON Maintainer Entry Profile
 ==============================
 
-The DAMON subsystem covers the files that are listed in 'DAMON' section of
-'MAINTAINERS' file.
+The DAMON subsystem covers the files that are listed in 'MEMORY MANAGEMENT -
+DAMON' section of 'MAINTAINERS' file.
 
 The mailing lists for the subsystem are damon@lists.linux.dev and
-linux-mm@kvack.org.  Patches should be made against the `mm-new tree
-<https://git.kernel.org/akpm/mm/h/mm-new>`_ whenever possible and posted to the
-mailing lists.
+linux-mm@kvack.org.
+
+Non-urgent patches should be made against the damon.git `for-next
+<https://git.kernel.org/mm/damon/h/for-next>`_ tree.  Urgent patches should be
+made against the damon.git `for-next-fixes
+<https://git.kernel.org/mm/damon/h/for-next-fixes>`_ tree.  If there is a
+reason to not use those branches as the baseline of the patch, please explain
+the reason and what baseline is used.
+
+Patches should be posted to the mailing lists whenever possible.
 
 SCM Trees
 ---------
-- 
2.47.3
