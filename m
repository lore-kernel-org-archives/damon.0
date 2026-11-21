Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795289623;
	b=WOIXvqbVBNTv0iKKN1szMb81hbT3uneaUKeMbsVbzOF4vYjIpJ7Ki+h70bA2JJT3YMRZ
	 KAEGwBYJfAmh+9X9JS5L8qatSaUQdrysRoZ2qT6/IgdyHyWX5fd2ulyGOSj0j8X8ZR0pC
	 D0Lv0WJo/UawcVxOpIeOR1cytQjBphI+dKuQidtjGHUF33eO+gkSfxgjYSlfmpMgKub+4
	 zMc1JsTJfsg1RRUXwmtHUQzSKSKGSnAYgyulxhw7DtYlOazw5994RW4H7klCIoRG0Yn6n
	 N5LGkmJ+QusJgchOg7WyCwJjHxFxxdeBsgDWaYYWdkZr2nkdyD+HaKgcZCmbkUIG+rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795289623;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Du4+njXljVHpzEo98PHsfc+3ZjNfYApucHyMGQt5m7Y=;
	b=TPoO4iH8RLF2kblk06GE+p3AukzB9xgkufItlHb9wAbZgjcwlihgkuAfdLmZAO6MdRAO
	 LPEW+ZSPOXejD1oFdulUaqocYKnyYs5pl6HyAgljjkGSnf4SATO60rvaCBMDAmTzHJwTT
	 S43diBayK5xkkHxhLu07138U0WGO7NtlqSz16blDAPqXwmNR6MC+E1MP8BnY8gIKpNs3K
	 OhnNACIpOg6/v8rjwJPLleNvBQE+XPU+bpk0cawxTiH3+AC+xhagiOiQqrLzVmFBhJjis
	 gfXdtQAVjey/oflpYZ1wQsEzLF20axHg4sdlj2M2vsZ7e5Vxii0pHSXa/rm5U8bWN7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ltpGO29A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92235606A332;
	Sat, 21 Nov 2026 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ltpGO29A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B5D1F000D1;
	Sat, 21 Nov 2026 19:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795289623;
	bh=Du4+njXljVHpzEo98PHsfc+3ZjNfYApucHyMGQt5m7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ltpGO29A1F5nrbBhSOQmDLG44uZcAg43fqIGY90Nro8h3p36bLZBNqvFQpoRc+GN9
	 /n/vA331PDUbfKYLMQ3gW9cfQyn0ZuLbqeFSwcFekQdjaCP4bP/DL6+w/86qNkRzVH
	 xQYdM55y/ZbZCMrtw0De8koDiXfX3FsfjriV8yAGgcnf5zfIH1crRkgAq23cHaihKg
	 jSBGoRGQZdujzElnNIWV2Ou5HNpi0Ek02mjGjO73Kf/yb2JIgcapOf2uI70P7BRj/v
	 EzwtmLHDhFPbN2e0FH9khET99CFx7O7w6Nci12NvBjZVGO0z/LpoHG/HK+l2Un6V5x
	 aqrv/rtXhW7yQ==
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
Subject: [RFC PATCH 4/4] Docs/mm/damon/maintainer-profile: update key cycle dates for damon.git
Date: Sat, 21 Nov 2026 11:33:29 -0800
Message-ID: <20261121193331.108587-5-sj@kernel.org>
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

Right after 7.5-rc1, DAMON will onboard the mm-next transition [1].  It
will make a few changes to the expected timeline for patches.  Update
'key cycle dates' to align with the changes.

[1] https://lore.kernel.org/bed81e01-7303-4957-bd7d-38e3a094e96f@kernel.org/

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index f9a8df2b11e73..75ad74b5b6e93 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -41,11 +41,25 @@ Further doing below and putting the results will be helpful.
 Key cycle dates
 ---------------
 
-Patches can be sent anytime.  Key cycle dates of the `mm-new
-<https://git.kernel.org/akpm/mm/h/mm-new>`_, `mm-unstable
-<https://git.kernel.org/akpm/mm/h/mm-unstable>`_ and `mm-stable
-<https://git.kernel.org/akpm/mm/h/mm-stable>`_ trees depend on the memory
-management subsystem maintainer.
+Patches can be sent to and reviewed on the mailing lists anytime.
+
+Patches that are sufficiently reviewed will be merged into damon.git
+``for-next`` or ``for-next-fixes`` trees.  The destination tree is decided
+based on the urgency of the patches.  Non-urgent patches are merged into
+``for-next``.  Urgent patches are merged into ``for-next-fixes``.  Being merged
+into damon.git is only for additional review and testing.  All patches in
+damon.git can be reviewed, modified and dropped at any time.
+
+Patches in ``for-next-fixes`` tree stay there for at least one week, for
+additional review and testing.  After that, those would be pull-requested to
+the mainline.
+
+Patches in ``for-next`` tree stay there at least two weeks, for additional
+review and testing.  After that, those would be pull-requested to the mainline,
+in the next merge window.
+
+``for-next`` tree is closed for new patches from -rc6 release to next -rc1
+release.
 
 Review cadence
 --------------
-- 
2.47.3
