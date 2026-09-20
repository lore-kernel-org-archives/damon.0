Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C83E8351;
	Sun, 20 Sep 2026 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908124; cv=none; b=AhtSnGTi2/3IPZRD2oo+6lkd4T3Fn5NIsVRFBjkfk2lJPO21/bDO0zgXVyPanl6jtvsfJhQnmKZ4siH7iq+NLhTxTDN3dGwNEFJmyP2izYOxaK15AA7k3vCFrv+hHY2mpyKO7d4W1jBfDi0XnKt/xFRx9refnLzfA27FVnppAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908124; c=relaxed/simple;
	bh=hXAa8TebHHPTC2vRzLcMLm9yqQmk7pg6J2XkvOBE0XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvrkiED7Bk1MiLZlxdFq2g6ZvEKyyffFPBt5GBXVdWMFUTJ92hdOt1wZWHNGVPbQstM71d9mG6ZGflUgS7wVciXJkoHX8EQHPNXMzL0EZZWbiAGZDhITy1mSg1OIWtFHpPu/Hv59XRDIDEs5VMJYNpGnMiOK2pVhFNay4YU32fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjkyLS/5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjkyLS/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D19B1F000FF;
	Sun, 20 Sep 2026 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789908109;
	bh=I/Dk70iptIFqCkEBnGECypzC/zMXIi2EsKQC0fv3EME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kjkyLS/5/JHLbJPv+EukS/16muH2q6u0OQrZMYRAW94AZmscp67vMs7KMni3kBjDJ
	 vd7dWzm30EgYYIukL7yy6c9jc4/n8snyNsbhjAlYAlZmCRRADVB0hUOWg3fWAVRR4Q
	 sdi4wotxoP3jPRfR1zcq6BD3FfYYj3ooFi2tITbs0L4gd50dEGfvdV4KHSmupgGJeE
	 l7pEGbyI+wxUJIjvypOXRVbeaXz7sIY3IFGI2bZGEtV4e0mEkcFVJRFdAlY2b52rsG
	 i1603onwebZrZ9MnbpphV3GSDY6xXJBqNg8Hkz/1ciekkAq7Ta1vzj2aGV4715h0pN
	 xG3rLo11+mCyA==
From: SJ Park <sj@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] mm/damon: fix the temporal goal tuner's size quota conversion
Date: Sun, 20 Sep 2026 05:41:45 -0700
Message-ID: <20260920124146.48423-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260920122411.610213-1-donggeunyoo.kernel@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As I commented [1] on v2 thread, this version is posted without ensuring the
discussion is done, and gave time for others to chime in.  I will skip
reviewing this version.

[1] https://lore.kernel.org/20260920123959.48279-1-sj@kernel.org


Thanks,
SJ

[...]
