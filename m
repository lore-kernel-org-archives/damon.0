Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.203
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795485898;
	b=sW2zEpatbGRuMEa9MC3lFGn9lld9ZBlOVxTsz9gXZAJXDhtdY2vEp/MmLY7cmgbVAwVh
	 E16qz/1fgC4AT3CUt9HLrRsPezQjekWgyq9142Z2tACisRrKU5V4Vhkjmnk9zUvZ5HD12
	 ctD4tMvIpbcARy6KQDS9AM0M2O/8EMsjEhfZ9ivlGf3q6Iw9GHDf6XOxzFw+CcZn9IlcG
	 ref0kgYXgCGamQHgbs1ylFLmtpiRcN45IkJJjVCBYWyWzFzND3TN7Um4U2pG5v0I/jHvh
	 B1Izetli2Xaw/4V/kG6omd+LL8H6vdbKUz4i2XTY9OMbH3/CX7F992H0q6B9dS5+dhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SsF+tVR2dZZjjdYGZuSRze/PIAMVBGDvDbNbw1sJLak=;
	b=nGuUHbgzPFl5TNOGI2YAFV2b/tdmNOchdf/R+3duq21w36OVT9t7ak0T1UGAjlsze4i9
	 3rx6oaTLHn3E8cjFGYjIfjuQiNDBDR/qYu+5zhVhtuy3xqR9QRb6vkCf4AA4dETxMkEX0
	 g0m7I5DxajJ+TmhZt06BLhmSnpqIHHN+KIoZnFUcIVv2AwKqJIcc2jrlroygsR9AzGCHy
	 TSBg69wt8blbXQkPLfVSaJ40XeIHHEqoUtmh2aHmShK2QnahRX6YFGdaS0Sjpu+JerS9D
	 17ggUm4SAGpDmtxNolqxPzE6AJQFC1knvbEAtKZ3OzQVrzPu1U0zXzIh/OeDExBnFXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pa1a8Yu7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.203
Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC03606A326
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 02:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACC03606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pa1a8Yu7
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-56820670d00so1411358b6e.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 18:04:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795485896; cv=none;
        d=google.com; s=arc-20260327;
        b=kkQDEjSWB7hYOLTp/uHIcwtmcdw1WgVvxFKW6Dl11EXlgWo60Ch0bzi6BkkPHByw6L
         ltlTrKi+5ft//k+XOlzXtr+plbBMfwWsXoaW/cFKCvPZMCJvEg4Vjgg+Ra5o77kHcIt8
         6BaxCXF/d8OXj6EVor5Gs7iDEhVz0I2n3glJ+v5ZDdzWhR2WLrEco/6a6INc/GUX06w8
         j+i3LQSk8iXUZNC5u657Y7JJrnzmsmQnxsj4IDQs+70+axw66rd3eTC9lzYzIKR05HRe
         nFR9uBht6CYXSQHDoo6lJo0vbM736rweGDQvulr5oBiTOMFMVLcFpfVG9Af6p0tu3b3T
         /50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SsF+tVR2dZZjjdYGZuSRze/PIAMVBGDvDbNbw1sJLak=;
        fh=4oNxFr3aNwSpQAKjdVWQUK8MKcmYd7h4oYUnot7V2Zk=;
        b=bG2uEZcQbx6ZXcox/Vad6DGj5DCfHecH23lkxvU0NVw5jEpEU6ayKV/MuGjznq69+E
         j7L4jVRF+w5cbS42c9BrOyeAzYfre80xhxnOV1U41yXiQLZrcHXkKoYz7C/PkCxjAqMV
         3X286NJ2KSsGmdykLZlplXl6P7qu/uNaSOw27SkPeD8nkDK7Potlf/pUzY2DQ1SQ/QWf
         WT7PpzMxZs27/rNxan52JKKYeAjNNEQfTb3EMxoFXJEa4jMpoVZLV4LpENw6rm15wxT2
         pSHI/Pf5f+APj0FJIWvnGHYCzrE2ocZtsBTM4g+jGm8UyNfpTDBZrz4dSe3AUSWf0n55
         zgmg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795485896; x=1796090696; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SsF+tVR2dZZjjdYGZuSRze/PIAMVBGDvDbNbw1sJLak=;
        b=pa1a8Yu7YjlBmkO8Bug46+pHNg3ozRMt0fUKw7MoOsMlTHjBYcs6D+1sUfATTM1a5N
         mtZk+WX/VZ1gw7y+HAV/VxRuCC33E1bRR1NGf6IjNczkKBFaCSVIAufiniGQ4Z7w/22f
         cWM6xVRwVkfqfHSdDFNuWr27K8PxNnych7PHp5cGrD7K2FbsJFygcjmVdbZ6Zj7Jaf+e
         SDDhTg7AZd4MVqRVg3TsjL6vPkDkYmZ9EG3OMl+cRt1qK6DRfCv4vkCNXyt6mtQTXoAi
         I1anuYYWSvug3xTOibtIGpilaSuIPYLdSbDCWcmSClnX7HtmxLpSbQqcYr7iy9r6kTGn
         jtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795485896; x=1796090696;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SsF+tVR2dZZjjdYGZuSRze/PIAMVBGDvDbNbw1sJLak=;
        b=RGyMkUEfrl4E2PR1imBfJqHaRniVi/leyKEx5RV3HXlxoOYERwylafy5z5W/7XMDYC
         RAXIhhABVaJQt6iThdpD4gMlzbeOnwSz6vxZZMZP9VpBT/qthAjbRiwK8er+gxw5qdGk
         3s5HIM0QGBRmeEkuSZU1t6YNnRs5wD+gOIHjYp7w6KAqCMsXX8o7FrKIODrqCv6A1Mcn
         MO2hCeH7XDF8iajZVRwIlzuUe4enS4F7pPcPo32hVo5UeVgGSwy/JdifA7LAXy7YuiKu
         Pllb0uaLAcg7mXRiM9yPYU9qFW8NMI7rWs2l6AVYhMMa6D5D7fp48qke7BnaOCmYlQIL
         jrng==
X-Forwarded-Encrypted: i=1; AL+hErGUjpiVK4WQN8axFVCmKSyZKGxZaJ71anp2qF6DaQJ17riwWPjp4qf6kLQzNF7facQ0B5FCcw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/jMM0cEz9JznrPWbioIzMoymZlDMHeU1tWu6JPpZ4Isv/1/lBc
	qPwLBhSvpUCNAkTPd1ZCKLg0W7jzbNIJ/nzQdJIAXlWA/E2ZhJF89iFuGwxzz9YIautvYIuytSf
	sUzjP09hVAvNK36DCU7mJKFztMZnB8qQ=
X-Gm-Gg: AZFdTZe0dX3Ixxs4eao8mo/ZfzX7EM0C1cvqneW4ZYH/bdbX4FdJrZ3kkohlZRD4RvV
	w+AKK6trOYrWJH22JxhPwoRC/J+W05YpgwYfqt8ULcDr2qHs3hP2agcsRyZPxvZSCwTn2El5rvp
	8HKBqGOmT/RY6Mj0Ed/ossu1z9zwBN7TrxFr+nVOvNE4+b0OCBd1rtyYrMy9mUqrWg7nQthYh1n
	+f8VGGAcWKeSltB6YfYUeJLOMz0cfzEX7OZD/o4qBciyFj/giw4d1BkxaFx3Hey9Xng+2rr0+7O
	0DfyGZ4Mb28W3bVWyK/it5yNzyUV6zyy0BOe54ETR8wR/MLT0Lc6gwjGc9mqv6qVvnZXBy/uutl
	zfSUNNaDmmGOU91Zm6mQWBbpg+TowizmCtvrONO0e7A9DAofVLCCTy9stNM88ewsvqqU0/fZF8u
	x+tZfD1gcpgonnewpTBDU81oKSeBLY
X-Received: by 2002:a05:6808:448b:b0:573:2541:1804 with SMTP id
 5614622812f47-57a0a20ac94mr14111097b6e.19.1795485896484; Mon, 23 Nov 2026
 18:04:56 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <179545322647.4.683470932650691650.b4-reply@b4> <20261124010507.90151-1-sj@kernel.org>
In-Reply-To: <20261124010507.90151-1-sj@kernel.org>
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 13:04:44 +1100
X-Gm-Features: Aa3M54pb-4ILmEklgmD1c2iD062twsVtwMwCSlytUWUvsxSnv-_pzV9-1H4xjJs
Message-ID: <CANOyQmFCkqfgQLda1EUADP2fVx_o6g+w8RuTAV5ugJ_sP3OkyA@mail.gmail.com>
Subject: Re: [PATCH 14/27] mm/damon/paddr: support REPORT_MADE type probe filter
To: SJ Park <sj@kernel.org>
Cc: Lian Wang <lianux.mm@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	damon@lists.linux.dev, linux-mm@kvack.org, sashiko-bot@kernel.org, 
	sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI SJ,

On Tue, Nov 24, 2026 at 12:05=E2=80=AFPM SJ Park <sj@kernel.org> wrote:
aid if that will add something that we need to maintain long term,
> without clear use case.  I think we could revisit after we get such reali=
stic
> use cases.

Sure. That makes sense :)

Thanks,
Aveline
