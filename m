Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967179;
	b=mRvKVa9x9BFkbVAEBLnlK3C9jYMAR8MtDGOzYI53PBp0jkwILgHlNSkUAM6z6Atk56lk
	 6VEXsg5ZZqYC9RRbCBkXMIEVCwt2Zf648fJLrZZEIS5Il7enSc1EpvfibH2O/1OV5RzB6
	 ft73qhoEswxKas7K3VOSr41ENe0T9qPSW51nxRLBk06puiQkLF+CmHUm6IJaF/cXuI1QM
	 sa/3KfTMVr4/FQ9ljISV3MTKerabQ9rVv2INjlbs+pXFhVHH++9Rp8M4Cgj2FI780pNDH
	 dhHVQH6pzyc3LQ1HQ/9/qXTiyK71diToFEllTyNbT/jd6Ccu25Yv/7LIzgQpnih9CJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967179;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=c5s/uyGsmm1S5dXpHxF7VvkZ/WKC43vJPwYlg7Viw64=;
	b=scs6PY0w3RCPAg7ikIHZHnun75L8m4Hmo03/tMT35mi+5EHEj2nCMSfLXLboykq7i8h4
	 b6GyEkTdtQIJx91vKbwhruE3iTikV9tXtSwglJkcNf+I6yUvtnE7K38yv6NYJ6+t2rrOf
	 q0LOUQ9f5ETszNwm3yE1gVO0fSXoTJ5z2SBKoPj+8JO55uywtaYAc1cuUJWPas4Y3ztvS
	 hqpwrmpyb0MNVwEFDsDVQpG6VuUeqov5x9+NufAxk/oK8z5/UOAvMGggdkapVYH3HK0im
	 jmfPUbURm4xaMffyjXe6WE6ytfzAITonj+zTwveutrXUNFrQ/9PIxky4wzlMNXez2Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heDsfP4w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F04606A31C;
	Wed, 18 Nov 2026 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heDsfP4w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0C61F000C4;
	Wed, 18 Nov 2026 01:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794967178;
	bh=c5s/uyGsmm1S5dXpHxF7VvkZ/WKC43vJPwYlg7Viw64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=heDsfP4wTRMcK7Zb31BbQz/800F4lPsuTxcE2U/Q1tbaUg3Xl91HkckJcmj0LQFgD
	 xosS6hOBcKnHxdOHMFmKR8oOSKzMcnbaXrTkXZjaaGE48imeUiy25Lb+wa6hmVXy4G
	 VO7b51oYC0GT0TBzGtnwXWVf3FACMVf9KyrX9ihBLBPOqgrJq89VCwuvj9PkMz/pzT
	 J6pIOngDvbONNR7/gZdCz1mTs6K2iK90RUg+Y1ZMl+FY6CFqLi5QJijdr4ihr90Ts+
	 G1D02P7L+AJ0Zz/iCnF4p2Z8MeniS6o2bUuz3dmt4y/8O2QIk1+zoAtWqZ/rENMl0s
	 3wy5YG5aZjZBw==
From: SJ Park <sj@kernel.org>
To: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mattathias Pinchover <mattathias.pinchover@uber.com>
Subject: Re: [PATCH v2 3/6] mm/damon/tests/core-kunit: test sz_ops_filter_passed_last
Date: Tue, 17 Nov 2026 17:59:30 -0800
Message-ID: <20261118015931.96943-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117-damon-sz-ops-b4-v2-3-439888fa04ac@uber.com>
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

On Tue, 17 Nov 2026 23:22:17 +0000 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org> wrote:

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
> 
> Add a kunit test for the sz_ops_filter_passed_last DAMOS
> stat.  The test runs kdamond_apply_schemes() for multiple apply intervals
> with a stub apply_scheme() operation that reports a given ops
> filter-passed size, and checks that the stat is set to the value of the
> last apply interval rather than the accumulated value, and that it is
> kept unchanged until the next apply interval is completed.

Looks good to me.

> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
