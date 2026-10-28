Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793165073;
	b=cPUDNdAx0/2xohyTXO22GWd/YEVHd3cfLdjTyobgpt/nPmVo6HxnrVBA1OjpkrHKYMXh
	 g9kWtPLBFXGTzNCIz72sdcyd5UQ2c1MG1hlpLHj4c9kNkKFduL6WoCN5pXqHGp25pu9eF
	 SeYjQ2wQOP/TBJMkG+2o2/duPBJ1PdG5h7SQAxLtu9b+bMdfO4pVjfclcvCn18wuP8LQI
	 UbFAylEYceIyReRVvsHGqmLo3pDcjKvdCO9RQURQHH2/MGSChqoaFsKuzLPlJs3Usfvex
	 FMawR6DTFbPPPgdy6XDLwxY43NAlRQxQuinCYjHWlEbvnF27NVuRtirG8BfAyLOtY5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793165073;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oJZAZ0A86kifY1NPYX8XYC0xWNprTevsjHMyzxjeHnM=;
	b=0sppppXqxKv7E14ESMLDT+k1EOpOD3mUgGKsGpVUUaGf4babSK40QeEuC70woNVz7zl2
	 BzUD90xf4eWEmI4/yjGGzvl7Km5Eju6qJgAuIG5G6M5SG3NxAEB3OyNHt5FIGj1Vt1az7
	 r6Os8y/2YsgOAOStWxmXbPwh9caeQTu0mVd0CnIZO4zaaCdKgIU6oIvIqWKkXSUI8EzGX
	 KGEtecfBNNRBfQenitVHXY3YRqzgp0XP+eKZIc/wcmXWaNMaUgsY74rCZCzmKYfm6UHq0
	 vz7vTSK4VO/LuwsOZo0X5yZgpb16MBPKeuorg93y8sMlcu+8WuHhTVVyrJt3wPXQ+RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngYis3e2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7A7606A31A;
	Wed, 28 Oct 2026 05:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngYis3e2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4059F1F01825;
	Wed, 28 Oct 2026 05:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793165072;
	bh=oJZAZ0A86kifY1NPYX8XYC0xWNprTevsjHMyzxjeHnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ngYis3e2wvUOSJvp8+0jEGKSRDYMAK9HDAntN9cymSinu549gET696m3116YIejwJ
	 5XIWt/Mp+Inwhh34rmXQnFzlmSbXuxweOA+gSdcBQjRlwCxPXq6FAheBvqJqQdZzNA
	 E4wKqnPVfaQAlZ4Q9i9McBUaVFtLkG+c7NtlMpsqccENGbmjhCiPc3cv70cYXmodue
	 eiab7TSuTB75C1kUmYTF2sV0N6KN9Ul50EVqFwxf4RSWnUpOYVgSmnti6Ms1sTCTGr
	 di74MpOpebIVO3Xyh3IelZ0EUD/1U+rRwUvsu+S/FEDd8MSxu6L20KJk588yv9LuGR
	 pMMcssqoPeMDg==
From: SJ Park <sj@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: SJ Park <sj@kernel.org>,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/admin-guide/mm/damon/reclaim: document how to disable watermarks
Date: Tue, 27 Oct 2026 22:24:24 -0700
Message-ID: <20261028052425.154616-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028023628.795637-1-ruanjinjie@huawei.com>
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

Hello Jinjie,

On Wed, 28 Oct 2026 10:36:28 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> DAMON_RECLAIM runs its scheme only while the free memory rate is
> between `wmarks_low` and `wmarks_mid`.
> 
> But some users want to reclaim cold pages even while the system has
> plenty of free memory, and it is not obvious that the existing
> watermarks parameters can already do that. So Document the setup.

Thank you for this patch!

> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  Documentation/admin-guide/mm/damon/reclaim.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
> index ec7e3e32b4ac..23fede7d1cdb 100644
> --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> @@ -193,6 +193,13 @@ DAMON_RECLAIM becomes inactive, so it does nothing but periodically checks the
>  watermarks.  In the case, the system falls back to the LRU-list based page
>  granularity reclamation logic.
>  
> +To keep DAMON_RECLAIM always active regardless of the free memory rate, set
> +``wmarks_high``, ``wmarks_mid`` and ``wmarks_low`` to ``1000``, ``1000`` and
> +``0``, respectively.  Then the reclamation is limited only by ``min_age`` and
> +the quotas.  This is useful for reclaiming cold pages even while the system
> +has plenty of free memory, e.g., right after an idle virtual machine is
> +paused.
> +

I feel like above might be too detailed.  Particularly, the second sentence
looks too detailed.  In a sense, it is not technically correct because of
'skip_anon' parameter.  We might later need to add more such controls, and I
concern if this kind of detailed documentation will limit such extensions.

What about keeping only the first sentence and dropping later two sentences?


Thanks,
SJ

[...]
