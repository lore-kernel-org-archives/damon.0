Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272766;
	b=F3cIe/LCFeqiVXmQZxArf4edJgHwik8rzOXUjCFXDrCRyfpmwOKngd2fTgPYasgwacSG
	 I57rFaDYTR4mmdeskdxN3hxPm9nHg2Y2SJWlwDUbtyqDq+5ho+bnx2nhl/Zz6NW1OzPLF
	 pf9ztHgItDSYO7WvL+mkaTK2hMacvJTNc3+UkERVxNMBIOJah1VDg2JutdKPb1EW4ojY6
	 p3t7mxRKGsV6cRQhPHqUg/mGcL3bx2p7Xe5xt4qP/Iak7cBuMDGc5czP31oWGlZkvzn3K
	 2MNmWEfTFrarZP8iasQ/ImwSwq4LR2stVow7iWN9UaXiu12xkgIex4z+KfQAYDtAcJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272766;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=svcdg7pOCEwVyv3Iw1ihpH3E5YTHskd9wIRcOX+vFpg=;
	b=0Nj40qeyopin17luZzneX/0b+aLaIa7DoZb/gole6cN70rRzl0Exsqr9XYWnFZPk4429
	 yqnknxxDwRHh1MJU0ci0Yfgm1LIdRmxlwwEykyQOrPq5i2FW/QIbYkiiqf5Mi4mnwwGwv
	 np3/OCVoW2Qd0EMxWuRme79AKzlzCQHvm0eFRP6DIpD6dTnLoaJLrty79hjyfXnqQ3g+U
	 +hglue6gkaix/oQGkLnFG9leD+RwHiSR/oA0TJaGqtKLKghUkeHYvoQnd7wpW1kdQmFAZ
	 ka/WXWpbRaDhCj1WcpO4o+roQ5TVNzxeDb2PjV/iaeVNYzcgcWjsLpxI/1RK5fc/SLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0yl27VA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD452606A31C;
	Tue, 10 Nov 2026 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0yl27VA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673801F0089F;
	Tue, 10 Nov 2026 01:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272765;
	bh=svcdg7pOCEwVyv3Iw1ihpH3E5YTHskd9wIRcOX+vFpg=;
	h=From:To:Cc:Subject:Date;
	b=k0yl27VAI1cV8UUWay7UD6tBKAG9upe0pA3a9yev6uGADzdj2zfshNuizFmmokQYX
	 /jNPOLFIS+ww7R64X14VP2EEAiL/bJ33Mfvg6jYkvWN7zp/R3bdGRV57XouMuvMxaw
	 cLVr71mADLHgKb4RNLkA5CMkYrsckKBIZ43RhglzYilRCJIjQ7gzgd4UP16i22ygiY
	 rQx04fHJs8bMWr7vZcTAHCjiaXrH6k+mSIxuSHGoraJ+eKI5g5c/4waQyAjBo5Ezib
	 XW7fpvvrno2zJy980Lb/Cb0A4qRNZGP6JmKGQDdwjUBBuHJDkUYgvy4YFUtxOb5jYY
	 75DCFhP2fkj6g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Aveline Noir <jm5905938@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon: cleanup region iterator and damon_reclaim user doc
Date: Mon,  9 Nov 2026 17:05:55 -0800
Message-ID: <20261110010558.104905-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

Two simple cleanups.  Use dedicated next/prev list entry accessors in
damon_{next,prev}_region() for code maintainability (patch 1, Enze Li).
Fix typos, grammars and improve overall readability of DAMON_RECLAIM
user document (patch 2, Manuel Ebner).

Reviewer notes.  This is a batched mm.git merge request-purpose repost
of DAMON patches that was sent by individual contributors.  For
changelog, refer to those in each patch.

Enze Li (1):
  mm/damon/core: use list_{next,prev}_entry() in
    damon_{next,prev}_region()

Manuel Ebner (1):
  Docs/admin-guide/mm/damon/reclaim: improve language

 .../admin-guide/mm/damon/reclaim.rst          | 45 ++++++++++---------
 include/linux/damon.h                         |  4 +-
 2 files changed, 25 insertions(+), 24 deletions(-)


base-commit: 7564fa11d57d7be37aaf791ff683099098dd2e39
-- 
2.47.3
