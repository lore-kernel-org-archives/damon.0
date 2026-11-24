Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536103;
	b=evIN7zxdLkaMUGmKAaNrebBajM+oCZHl5jv3o6rGDWEZRtgRbuRAkTE3mnWjZIj0z6DH
	 q8EpDCQKX3X7FrhZOCDwVpnNkLcv+yiTwl/muJ1BmiS/F6qhXYKwhxEj1NNyeZeS9Zjlh
	 JSZ11b/5aMrbR0Z3u1oujckwPVFLI2zyHjMwdUedv+lkkBPke0KXwTFsn1KxMCPr6pLHT
	 HY0s73CjJnQMZLm+Ha9vATmsmnN62tANLVDI+c8wacTcYtTC+kiLoRB13ggl4TYpGMJPG
	 gDN294iCabD7onCx+tck9vJU0cwhdoUJqGqAKMs/coA7Ehb6G/IyaY6JZJMElyLeJjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536103;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Du4+njXljVHpzEo98PHsfc+3ZjNfYApucHyMGQt5m7Y=;
	b=wWYSj1XD14dwk2mynOatroFo7Pm3lcT6Vkb1i+wEHrPOgIgXBpzDOL5wov8zj6VBrO8f
	 POuh5MeJonJJcRrH8u7nFJ+vfbXxI4jgKbeItg4jLFCaFe9ToEc/sumNvXaK9gfEBHM1j
	 qcGoVBxiQce/JT4Mm9oF/Uv1aXJ2OLXg0XLutaVezXTVn/4/FgOdLQOfFUj/Z6R39In4Q
	 ZPT3i/xuDN6HOR1RNHUHB9/oV04O7GFuhXAuJZHawhXh5o1fM1OObutToJhdSCe18jPY3
	 eitZAg+pyciXJEQOAr/c7G+yAexsItdRcmyy6a/12bqveZ4vcUdKkULBtcedDo4Ofiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDQYVOj8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE926606A329;
	Tue, 24 Nov 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDQYVOj8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF121F000C6;
	Tue, 24 Nov 2026 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536103;
	bh=Du4+njXljVHpzEo98PHsfc+3ZjNfYApucHyMGQt5m7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WDQYVOj8a65hn2RvWgNho+NV+f1QlKJPQDCW2sH4q/NlWxK6rf5AziCUxH3wrCw8Y
	 opR2eOGEFMSX7ZT4I8Yk/h3C2gcYCaad1dYUJjCXeXk9hkhDszjXa4Ys7n2ljfFssL
	 gh3Q2wvezr7K+/ABgzDTpzc2g1mN8TWNfyvUloV0+1oo4rucKEs3MtCxiAqBzm0MKv
	 jFsI3ml2vSXuI238Kfsp4gRJHRNuvqa46AH89J9gN+BwLJj+9vAcykgWjd5ciw4taR
	 KLJzmQPr29VzEFemqWMG2/rhM6EFFWUFV9A3Yzx+SCXKi62t5CuWYkGbppUubvKy0a
	 uX+cEh+t0ouPQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-new 4/4] Docs/mm/damon/maintainer-profile: update key cycle dates for damon.git
Date: Tue, 24 Nov 2026 08:01:22 -0800
Message-ID: <20261124160124.93482-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124160124.93482-1-sj@kernel.org>
References: <20261124160124.93482-1-sj@kernel.org>
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
