Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.130
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795363589;
	b=pgUFsPHFYKefYmHMRCYSh99Udu95G3/3YDlIfBGYhVDX2jJkWvpnWpT+2SBvRrN0s9Ri
	 oXTbsdycNEb95AiXwtphVqzi77xYTUTt15hf6GbvLVMKyu92u2ikOJvrIf68ozBZ+gKeD
	 Jm8ebSAz/I9gk9E7MYNHl3m405tl2uZDlLRw1Eu7ROTjUwvokgrDm4QOFhmnKgxNjPsu4
	 74w24KMQDaq/vrk9yOFXv2C9hbqKCYpplbgASCidCtlSIlYJMnA0797RBFwd2EBpVYRLv
	 6TmS0TQGf+fdg9AS9YdqDowE17n8jLa/6Ms1egZ/CxBA1ZCaG5bnvLzGbIJ8icJX7BQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JWLHqnr9eQ0g3Kih2Y86iBXbNbzuU8PKSHvSPjCQvmE=;
	b=OROJtLzadB1vFFnntHTtVcZbmGBSTU4vKDNb13cxlPv58Sodbk6y/N+jorWfhKVMVeQB
	 ychq29UAhOEuHH9c1gLbo5mMZxANocloWfLeqCcx4IrVX+q9t4HCRCW3pX6K4mEXXaiov
	 xc/O8jEwUdCwP7He9rAs1CJyvLVQkMMNisF7x+rFviRMdCWyJx+1uHLjI9zUhG5Mf7+PN
	 SzvtFYhyafaELiGkmTnBM9a/qDHHKhgTpQhihhiSSJ2DuAZxiOZVL71H6DEmxjzYMZNYT
	 XGVMppsSnE8FV7DfRCzbv7hTwD84aGi+8QCVf0kixXQEYfoPp1qtyThbTfNAJCZU5+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cwk7qoDj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C2606A320
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 16:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A83C2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cwk7qoDj
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-8629ff88e68so1071407a34.1
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 08:06:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795363587; cv=none;
        d=google.com; s=arc-20260327;
        b=Pwn6bHQ6oQ+f8meS0uE7ew0mzDw7ilElwF1qBS3jFf1kmJg/61NbWggQndhT+lwOJ1
         seJmFMpRpFoxYJrBiK9EbOyTRX0H+EbJjVaCQOnw308abjGLG6mYKzgoFmvQrAjSqRJC
         ETZJesXarJC+DAwNG5eNIS+m4beBudvICs68gH20nN+CEBIn43qn5B6ZsgmBF/VBcLta
         wmpUIerPkDZPnpfRKxYCxYlxN8tH0oNkE8NvhovN3nq1ei06yyFcJUSspzFV48OwNi2p
         BW0xgI37ayS37PEwnzNQnkC2itaXWSx+/qRKZrY94W1iNuN9oCT+tgaQAAQocTi+REil
         8u1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JWLHqnr9eQ0g3Kih2Y86iBXbNbzuU8PKSHvSPjCQvmE=;
        fh=dA07XAJiJxOlQF2rtZLgl0dj0ERb5wLZOelSKuUVUek=;
        b=itJ0jmMzxr0IUE1Ovwykivf1JfCiEb0utdunwhS8rO7q5Udh6hvjIozfSIelCBSdEP
         2PacxejbMhe4CJMkl7UjEMd6yZGE4pMxDmUqxh3toyhPMFi9Yq7tvh2HWeK4TxftdMjc
         aS3J8KYuVyhx+vmwX6lndtVVBXOGPFVzIXBCnC48AMA7qm9PoG6G3BmusL0Aj35JU4YX
         aoEMROstwXAas+uPqWJvC34VkAwvQuXJVF0K/vFWgnDMLNbkT5AS4JxFHBonuHIepaqA
         oxtslo9GaZTPpHbrOq0PqV7wVpCGNszn5BXfwsMDnFOrOD7ATIY1IPB/VpMRVOJDjXd/
         THaw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795363587; x=1795968387; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JWLHqnr9eQ0g3Kih2Y86iBXbNbzuU8PKSHvSPjCQvmE=;
        b=Cwk7qoDjqSRStS0AZb8EtH8/QXAFsZH4v4z82NCisvccxrBEfm/xyVxVOtOpvgdrd7
         7PPIbX76YZde9vY67aYTkbK/2HYaYqguZXpCFscLJY/omqp+jgJeXBLeHoi0ilmT8iD3
         dES0me7UXrZiMlseBRrwc15DSMEntmj5uD1Mcnk5nI4XfN1qhtEF/5kQzKIw1P46lW4D
         6PmmU3k087QULLpQyIyYYZ0yR8A096JMk3YLjpu/EcxvahFlsmPnK/rb/FPYwmVu6cW+
         PBdRh0P3xytxfr1fhH9N2L7m0zLFjIszJWGREmm/fVo6NNqeB9OEoJRS1bC3JQaUblqx
         0BCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795363587; x=1795968387;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JWLHqnr9eQ0g3Kih2Y86iBXbNbzuU8PKSHvSPjCQvmE=;
        b=xa9jaSzUy2TNbrXdONy0S6N4UE/tROXx81Me1Fhj2StK8PYiwVAPaWbfnHgTijGnrq
         LDbUvV0+QQZWSpAYpZZV+/HF+UB7y0Ho5PG9fanDM4ve3mrNQAmwLbG0GpLyL3beJ1IY
         LJ5EiD5Qn7Kw7jvYwhuPL1lhLmcg2dyhmfoSQthHWMo9zD2x3y7laP+3aX64Eq31O387
         6gQ1Tru9znfrYu2Gkryd7nDmBpInb7SZVmuagjgjAeXlrE1LAluM3RKmQxjfb2pvBQrn
         esQ+Q0L2aO4Q8tyrAE08FxQOHwTJc0srM0M58571H4LUnlyKO+c9bbTxwKn5S4y/CF5m
         PD2Q==
X-Forwarded-Encrypted: i=1; AL+hErGYOOzSCX31ZTMjeG8E4+pxH/Tftwwx/rdo4fpxshxTLOan78NVXkssp1BWDomuTmCvkr0pAw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9e7uCf0syRIhqrPSnWVox3de3Q3DMpPRUHtVvsmOtRCuEHClwx
	SMM42tP0OXt6mfDxXK9N/ETD3+dqxGaHsVkfL1YgXRnuBu40haG7AqA0CHUyZnbd3KLkHJtaVHM
	Z7DO1grGPchexoR69MyH+IMOU4+sf1Uw1idRSDnMGMHZiT84=
X-Gm-Gg: AZFdTZcfHjlOk+MVjWn72MFrUb9YRHHiCpzgIEBm8/6zoxrJEoHHu2SrDGRB8kh8xer
	LGQ4mf14rgtevtjo/IYoBLZanvl/PHPWsTeYzhv0qTjRxNECfCf/xF2ZVG9DgUDRB+88AEJzfE5
	+8yaB0PbJOS5xqLbfnWNdSNRcjIcQWcryfmkYjVz+ZuiSZxxG+IB0TYKOUnVQFnOiGMrXtFeaCc
	c9bOihHhL2P+BGqHnXaEZQrgfi54HvvVqfTrzbTTMJnV52+VBeFnZp4iSZvkGgRO7gCL7jWU/kD
	VJ0ezPNNq4HL0C50gUXGVAAxjCCzHzPj5Ql34AYkbZ26dXU9jQuy9kTslcWf+H+p60zBzlFmEEO
	aEx+c4KuGhaZkEhZ6vLnSJBEm1I0s+26HrO4C/p5f1mLTrp5p48bYWsfYTFWA5sUYfDP0wScI67
	Ugc8JvPQPsCdxJcHhhH303vvaczhl0Vw==
X-Received: by 2002:a05:6808:191c:b0:4d5:27da:a492 with SMTP id
 5614622812f47-57a0bc8d4d4mr10610217b6e.44.1795363587423; Sun, 22 Nov 2026
 08:06:27 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-4-sj@kernel.org>
In-Reply-To: <20261121210013.130397-4-sj@kernel.org>
From: Aveline Noir <jm5905938@gmail.com>
Date: Mon, 23 Nov 2026 03:06:16 +1100
X-Gm-Features: Aa3M54p7uFGEPCPkwkXIjb0l62MMf_8Bfq2LIyaO0NY-QwLa3_skxD1OEKyAMRs
Message-ID: <CANOyQmH5FX18LmMW+QwAcvOiATgUqx5VH02S5DyfTg+qPMSX+A@mail.gmail.com>
Subject: Re: [PATCH 03/27] mm/damon/core: introduce damon_submit_report()
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SJ

On Sun, Nov 22, 2026 at 8:00=E2=80=AFAM SJ Park <sj@kernel.org> wrote:

> +       queue =3D &damon_report_queue;
> +       report->jiffies =3D jiffies;
> +       lock_old_val =3D atomic_cmpxchg(&queue->lock, 0, 1);

If a submitter is preempted between these lines, it can enqueue its
report after one with a newer timestamp. A lookup scanning backwards
can then stop at the older report if it's outside the window and miss
the newer one that's still in it.

Could we move the jiffies assignment after a successful cmpxchg()?
That would keep timestamps in enqueue order and better fit the
meaning of "when this report is generated".

Thanks,
Aveline Noir
