Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634565;
	b=lYNm6F0OpilcmlxwiWTHbdw1td8Ok5+hRhv6BCNQiiY4qnai89F3Q/S7xHfsjBbPFAsx
	 TwzZMGHZXjp5Nqjp6yEpyZnNCTxYvL07TgQsV2LsTCE7+73hUcFf11yp0a/kkBel1vs5E
	 DcRVp3op8in4HRoQUfG0kqcD4oxQT8mG5P7Ml41+/VHm6DDCDbnvDXp2reBiCzHA7t5p5
	 xShH70ozXY47eL5bk/U1u4p4X1WCNjnp9UtmX7k2A7NJtbCIY9z5EA1iQmODWFTZA4Gxm
	 Lze29DJjw6hmHXuMvFWiopHyHv6JJV7Fj7cda0lFUHKQ6oFlQvuIq5ZSYAm2m5bk6dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634565;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7iyy/gzO5i5xGg7RKRWVm/uJUgdHi052Mf3l4AbZX5U=;
	b=p+Ee0gUTEj8Jl7fcS5jYoLOopO2sj6SJbUa22PAi/ru2TFyxthS8q+jaUeidKCzxsKtK
	 ARclZQQWjsh4l3E5oRcfRe89oKuuR94dqjskinpx8zTKXyiOezmbNzJPsYJvySq6JYkR3
	 NYRxHVPvlUgHKamwsFKVR+S5aJwrWSEEqKpfq07xc9uwpbzzd5c+imJ0tFv817z2K1sys
	 qg0pv8WxWmVm+JpUjGGRHVjkoIUy45/5sqR7wd9GSywGAobF5TcOzzG2Y3YAWXqH1j42+
	 2cKE2GRQjcW95f0zspZ+CQTnKF9zeZweSXOJeUHmREGJs0zdq1NNpT73JPj1y2LfdwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cc941YPS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A56078248;
	Mon,  2 Nov 2026 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cc941YPS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14D61F00A16;
	Mon,  2 Nov 2026 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793634565;
	bh=7iyy/gzO5i5xGg7RKRWVm/uJUgdHi052Mf3l4AbZX5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cc941YPS2nfcu/fdm4vKy5uACeS7NcqKa+wn1Ax+CmCToZ7mXauxuURM0O4tny9ld
	 6mWnKcTIooZ9IMq+yKdvUGUbGLSsrs0RG4k7qLucYclzvUGYk38Kz7HD9sXxjRrFdx
	 1PxdyrtJH5xVBt6Kbmpt6pgt9hidNgKD8TPy56sCzVSggBZhzlKcfikdyak2TafquQ
	 Oy7liuLaUTQWt6LIb+vvjAsCm9gn1BZrp02R2D/lfoKO2Tf/XU35wB6dU+C3j0iMna
	 yQVZMe1VBKfFIiD4Mk6k4T2BLBtp23slHJpUYw+2HbObkpws1A17Edz8akyZS30gWE
	 SoRMW1h6EAZ2g==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/3] Docs/admin-guide/mm/damon: minor fixes
Date: Mon,  2 Nov 2026 07:49:17 -0800
Message-ID: <20261102154917.99512-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102152849.96057-1-sj@kernel.org>
References: 
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

Hi Andrew,

On Mon,  2 Nov 2026 07:28:44 -0800 SJ Park <sj@kernel.org> wrote:

> From: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
> 
> Docs/admin-guide/mm/damon: minor fixes

I just found applying this series on mm-new fails, because this series depends
on another series [1].  Pleae apply after the other series, or let me know if
you prefer rebase of this series.  Sorry for inconvenience.

[1] https://lore.kernel.org/20261102150757.93058-1-sj@kernel.org


Thanks,
SJ

[...]
