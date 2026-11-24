Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536103;
	b=R0lB4dtCvQc5ny4CdaoFDU1ZSW0eyq8HKWhrfWhxiZmMfocpC1iZctMOk/maLPSinWAs
	 EvHCFNFIa1lMZn+TrsPA/VYYExc6yMtUSZw2oUQofY4C4k9UPAwqQ6k1RSiWV8UP4ag1S
	 g50XBWfuTGk47DEwppZO4Humx+Ftaz8GBdBjpLW3J2EVvR1kLiWabV7/mPi45rxVqhJiu
	 9SXRrUY1g5e16FZY5S/U0dsdhEX1zPmX9UhjdoVgB6DsTkyssmsJGgzKcixW+cWlE6okU
	 eCf2sDh1+pKyjhj+Lf9PmqV4RU577DtHtWYp5lWvEGp5hv5a7jf3uz3ql4DusrDcuHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536103;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xi3zTL53/C0IsEtzXdFhLsnsp6QQLU3JdQrRy1JaaPk=;
	b=ce29O717Nw9/fukmAcnGFN6l66g0c/TnobUe/F42bIAHGzI3k+p54X6gE3rGAIMiZ26B
	 FXDwbMhfz3+WE1b0ZaUQcOK5HzXZDvlRn1wYeZUkTnWBNjOHda/VhUPziHA5pWvnPOCLQ
	 DP/NCVXNLimoHZYvBsmEsMxC10msEbqgVGtvZhyKskIxmcCpcwZfXOdXLA/FRIg645QpU
	 KCINic/IFIEyYJwbLigr1sCB/SJ5eccaSGs4opgyVsYC1P7ErwRnuBiJonkFsxHrAhUdO
	 ubELExOSydUt1gjPMmVz2q3Z/GJkFpDtqo/SAJusJfVHBzBmXZuDGsxd6MFikybitcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9m0cGTx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480A606A334;
	Tue, 24 Nov 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9m0cGTx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3561F000EC;
	Tue, 24 Nov 2026 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536103;
	bh=xi3zTL53/C0IsEtzXdFhLsnsp6QQLU3JdQrRy1JaaPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R9m0cGTxFlXMWBvDogU+U5G7ey9rbNsM5GBHrH7X0OcvdXfuWXWLxrWpAe6Yn6vif
	 50LT0m5pcHJlKX8a/gIPTdvLMtHSQUinzAqK562ZlZ1yvCVrOy5SWIFb4zF2E7dDU0
	 RWPkTJeBlj3qsSJV4qwa6vV25/46BGezOTX65CT+nQKEcs8Bx4hWRCToPk61LhzLhw
	 Fb7G1M3UTARQRRcp3x4Ab2FeQvru2CO4v3u5UFoeL6HgEkT6Yl//dkypvfufm19eM8
	 LbwkKIrgNLQNPQU5JtOw+dltieXzPofh1dZdTMMjVGtOZerrC6m7/UhQ/lnqMAK50w
	 ypNX3IvR+xeEg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-new 3/4] Docs/mm/damon/maintainer-profile: drop 'SCM Trees' section
Date: Tue, 24 Nov 2026 08:01:21 -0800
Message-ID: <20261124160124.93482-4-sj@kernel.org>
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

Right after 7.5-rc1, DAMON will onboard the mm-next transition [1].  The
major change is that it will use damon.git [2] as its SCM tree.  'SCM
Trees' section on the maintainer profile document will be outdated.  The
updates for the new process would make the roles of the new trees clear.
Hence 'SCM Trees' section would be no more necessary.  Remove the
section.

[1] https://lore.kernel.org/bed81e01-7303-4957-bd7d-38e3a094e96f@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mm/damon.git/

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index cc6b79c066a64..f9a8df2b11e73 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -18,26 +18,6 @@ the reason and what baseline is used.
 
 Patches should be posted to the mailing lists whenever possible.
 
-SCM Trees
----------
-
-There are multiple Linux trees for DAMON development.  Patches under
-development or testing are queued in `damon/next
-<https://git.kernel.org/sj/h/damon/next>`_ by the DAMON maintainer.
-Sufficiently reviewed patches will be queued in `mm-new
-<https://git.kernel.org/akpm/mm/h/mm-new>`_ by the memory management subsystem
-maintainer.  As more sufficient tests are done, the patches will move to
-`mm-unstable <https://git.kernel.org/akpm/mm/h/mm-unstable>`_ and then to
-`mm-stable <https://git.kernel.org/akpm/mm/h/mm-stable>`_.  And finally those
-will be pull-requested to the mainline by the memory management subsystem
-maintainer.
-
-Note again the patches for `mm-new tree
-<https://git.kernel.org/akpm/mm/h/mm-new>`_ are queued by the memory management
-subsystem maintainer.  If the patches require some patches in `damon/next tree
-<https://git.kernel.org/sj/h/damon/next>`_ which have not yet merged in mm-new,
-please make sure the requirement is clearly specified.
-
 Submit checklist addendum
 -------------------------
 
-- 
2.47.3
