Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882367;
	b=eFn2THdwPnqVLUspOPTheeajUN2/FhttjaiGXuZYxroDSE80m7rqzdozvj68KLAB09Ak
	 PKlSmeEk10BW4edA4iODWWa3+p+WyOvp3F4DGU7IF0EA//ETSZ97F1KcXw3G80QctsmZE
	 8B+OUxa4bpZ5yQzGcbfFmsV1lu8EvMbg8bNOoBMSSMPJdhg2pNL97Dv8kxGAe8j046PIk
	 kIQd6f7lhgAgtAADNzYSDe9mHz/E9mcItp2uYf+e601aXOsEAK15IVyvCTd1AA9dJHtFA
	 LenGX6Na9kozcMzo/fycfnhpjDqKmUlPDamtMuYTuRxy23v3EDzldPmXZKYcd80elig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882367;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PwJJPpk0KtufegXyh+UDHeclSfuYI9J6g+cBDWGlDL4=;
	b=d2zR4CaBDQM9XHp2duCY8PFFGym2KmfHZ7YbPQcf2jtEUnu1aaYmcyrf8jlZ2KRB5hFJ
	 2QOswXO4WlJP752kxbE1tmAqHm9TJelsNxJ7v4KrVOIpoSqd1yJJTdFRbX4PuX4uzTQqk
	 Mo9LT3LjR95vg7zrHPkCIDo6yQ/+XO2Iflrku+9w6ci7Vl/vS9fgh6l2IcqpnAzQ3dM8B
	 byRInwerehVxaLTL50yEcsQsTc4/LFN4x3ym/eBzAcVx5ctSC8xs6poy1as8ygvhyW9Bj
	 YZXlnTIjVzIK3emOzI0uwSf6gpGCl5JlcTDcDrsTTZxx+8sd8f3nhN1+O4exTNhzVVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kBnDPekR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897E606A323;
	Tue, 17 Nov 2026 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kBnDPekR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCDA1F000C4;
	Tue, 17 Nov 2026 02:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794882367;
	bh=PwJJPpk0KtufegXyh+UDHeclSfuYI9J6g+cBDWGlDL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kBnDPekRMxV5Tz1ixrttniVUjQ/Y5abW8tNTlEf7fOi4ZaOX6Xysah5INbCB4LJdt
	 PNYnVRrO1c4KefQkUROFHa50Q/1Ng4uM2DQyk0BXX/yUL7xXEYZ0cCnszuKRxfXOhD
	 dnkI+MYADUej+9hL6Bn+Aqomi3Mex2xIbLGg5NxcZh+zWOwIn0X7NjPT7ey7EC7UA6
	 pq+1ibg0NnHaYLzC1fllDwWWjO0DTTClfja8fdc2g3XTjosIdnGN2cSulXKes5vZzM
	 8v063ap8izPeUogb1u7LU8Rcg/3G9K2FNsR+eiJeLhSep/qh3Z+MNGJnKV+fM5b3m4
	 MnnqolfjM2waA==
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
Subject: Re: [PATCH 4/6] Docs/mm/damon/design: update for sz_ops_filter_passed_last
Date: Mon, 16 Nov 2026 18:25:59 -0800
Message-ID: <20261117022600.110435-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116-damon-sz-ops-b4-v1-4-1cffe7227e6d@uber.com>
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

On Mon, 16 Nov 2026 19:10:07 +0000 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org> wrote:

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
> 
> Update DAMON design document for the newly added DAMOS stat,
> sz_ops_filter_passed_last.  Also explain that, unlike other
> stats, it is not accumulated from the beginning of the scheme's
> execution but shows the value of the last apply interval.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
> ---
>  Documentation/mm/damon/design.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index b676be697158..e40b8c1a3461 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -876,6 +876,8 @@ scheme's execution.
>  - ``sz_tried``: Total size of regions that the scheme is tried to be applied.
>  - ``sz_ops_filter_passed``: Total bytes that passed operations set
>    layer-handled DAMOS filters.
> +- ``sz_ops_filter_passed_last``: Bytes that passed operations set
> +  layer-handled DAMOS filters in the last ``apply_interval``.
>  - ``nr_applied``: Total number of regions that the scheme is applied.
>  - ``sz_applied``: Total size of regions that the scheme is applied.
>  - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
> @@ -903,6 +905,13 @@ to exclude anonymous pages and the region has only anonymous pages, or if the
>  action is ``pageout`` while all pages of the region are unreclaimable, applying
>  the action to the region will fail.
>  
> +Unlike other stats, ``sz_ops_filter_passed_last`` is not
> +accumulated from the beginning of the scheme's execution.  It is updated at the
> +end of each :ref:`apply_interval <damon_design_damos>` with the amount of
> +``sz_ops_filter_passed`` increase in the interval.  Hence it shows the size of
> +memory that passed the operations set layer-handled filters in the last
> +completed ``apply_interval``.
> +

I think the description is clear enough.  Could we drop this?  I concern if we
will have more non-accumulated stats but forget updating this in future.  We
could add this again if someone really get confused about this in future.

Other than that,

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
