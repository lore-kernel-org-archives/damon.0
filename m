Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793145439;
	b=QNIrXtt+90KR2zKKpUgguiLyC62NsnVoPrPDMNxiVJJu3uEaH/ECYkaW/HPEIloN4rPv
	 BFYFeoODrdjoUPEFCWThOUTiFF5D80F+70yLFp/c1Yf7tUDQlxY4HutOJ3dzGu5/b795+
	 qGi4sj5DeVC2HoekGR7Arz5dOSBPNmpLi9VXj9ia5PpbyiC+/qFNqs1rw8NVsJpArFY4G
	 nkS0ZuIo8SQLyf+bUV1Ap+RPbHcSc/IYwOdiwZp5Zgs0n+ZMMOCy/xqqy4wCHJuWhF8+4
	 Z5u8zxr5m2MYfen8lXKO03h6WUnydAUzbj6u5SkrQiRgbRVrhWwuOG62/NLzi6wU5Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=tyLuWatZQwuD0wqN6huARvqhfVRglzi7qhQ3+et65cs=;
	b=zW34WWe4Ukr4ZikzYzNqyrIGMicctnnKFPd/PtTG5p1okXz+PEcwnSmQcuHAxkQexqG/
	 SFOQmacHtBlakSVeMJpXXZT1a9DODqR3KDzMZOtxJiTErIuL7c12/dXoFMfcAAsjsY8yf
	 FFwE/JoU4wHFi8WPycBBzm0FN1Td/hZik1LxPrT48kZHe8G5On7l/pHd1r7nImsXeZCt5
	 H9j+NB80cXi5FWO4r2EMz985IVK+99fnuB9BxP0goGFc8SgUNg7K2XusJzEB31M4mC+h1
	 y1COjy1+bq2cB4F5WT3EfI9PNIXAmQFbfdZe2/LrdT9xxLMozgR4oIjji22WVbH70tQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QGPvmwed;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA81606A31A
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 23:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA81606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QGPvmwed
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0f1dfef72so406667b3.2
        for <damon@lists.linux.dev>; Tue, 27 Oct 2026 16:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793145438; cv=none;
        d=google.com; s=arc-20260327;
        b=FO9fFh5RIDp4EB0CFrA7rZ4CBLqhlLUVmm/3WSqbqAkO5wy/iUzqKFQK+xbKcBNo+l
         /8gaxPBraxi0plYY6Skw8aHHa2NJYOjdtCO1TInds+Do0o/4X759G4Zw3kYSfonuVUWN
         Ld5MlrjA5GzrMTmLsw1o92WDBPEegZ4JwMEm93Z4HGfZDLTgthMe3vIz1mrlIx91fDo5
         rH/eZ/Jz36IB5kh3xnV7XNKId3edZ+jCRr/mU7Y/EskZUzgFYyX+Xv4Tm6L0RbMpUcCR
         uibBi8p9p7YsxicsJknC/L5qKH4zi96hUM/zRaK77iD1pczWlXqulyT7jm6e5gFdZ54M
         IQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tyLuWatZQwuD0wqN6huARvqhfVRglzi7qhQ3+et65cs=;
        fh=nzGyYFRFPwIIpIV+OE22FXViGccE7ivnWOydWo3K4w0=;
        b=CILtwbU/qvP/Wq4cHNr3YF32iJSgnINmd36OHUm/noHn4fcI0Pm7fWR3qkNa7RvL8Y
         J6yKXbe1Y6XQ2fnIQ0LcNd2GziKbVLaCmhaZl0yhJZ0KfNd5zq9fnUxP2dBoj91Rhjcn
         nbZGBxya02KgoxVrb0K1gqx8qkVYAzSBRbq5BchqhLZzdljquzXYZoe/+CwO4RlF79GU
         uQZDHDdNVziIN3i7qxWyH+MPGBAHw6aBmtWQrQVJDZ7Hlf3zdvT/y+2LN7ejCLx5MJHE
         fEpegxO0J3/GjUp0SCSQO6TpPNuHtRoUep+Uo1Sfwk7gjanqBzeMX794MyXu45IO8CfZ
         g5Mw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793145438; x=1793750238; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tyLuWatZQwuD0wqN6huARvqhfVRglzi7qhQ3+et65cs=;
        b=QGPvmwedPm6USqdpVnzXzeG/sDXBp1y1eyWJMZvnQ6b+YY8BfEVgsosn27aMJCOVoF
         uH4HDp8ozt9ItwAMdiAYjhfhwsL07CXO7nZyMwpYh+W7RYL+4VFsXUAUpytkcDSFpDNv
         a90IOnfbyBqTr2Mrzmt5HRgD41HGz9U0IP6353TufKWAtZFiA3PVSRCHtIGV5QFKCs6x
         bi5/IstkD2O7NEUDx7L1TXacy7SM58Cn84zNMvd/i9xve7l0mI2gbvbHeZThR24bLLPV
         3F8xIbCbV91c+4AEkeFBLyQkzH9/ZDCKWPqA02pSWYo0s4rNke2+nFsKNciKpYVOdRxp
         l7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793145438; x=1793750238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tyLuWatZQwuD0wqN6huARvqhfVRglzi7qhQ3+et65cs=;
        b=MgJoxmikbMfjGWbuH2J3NGrqTmCIXkhLSQoQKqkV1YBZYjPSsP8lNUG2KPl+V4/uNW
         ADmdlnr/2YZE4bzcLczEB7S6vJ8WIbV8XC2XxTuPt31cY7eSm+YQKDFEyYmZbNjqqRuR
         RYUu4ESHBkURL/klQpR9+v6uTCDrmvzNXvX0w0VAyY0RjhotmqDxsvpu8IY1cp7+cQ5S
         bWQlu/8p0fgQsyVA7yAqo2Dio7jaELollx87jIGIqA3Jf+env4BVm31infTdCLNaY4q9
         /7btH/ztG3cepeRu/Va0WrW2YTYBe86gBTffmEGqbvYkE3NB2g7nDGWnvwVQgZFwjfhW
         Cc4g==
X-Gm-Message-State: AFq9FYJgqnUZ+JhwVru1HwLqxz8bwIvzJlbl4w30BkrPyx/KV6vEn80u
	QbODw4bySagRu0EIkOnqXkqr2LERNI5R/oT4cZGIQTyECILkyrHs/k54Rs4QPE6wbLP7yulaq/R
	Ouf24lgeHZE9yBBGDpPUk/UTywCXt7eQ=
X-Gm-Gg: AYBFou25DqBlNyvMqAUn7xi7sE88TRa9rA2vVsXuEedn7gcEN0J/uARYQIGG3PGXOuS
	TSV6QuLS/1wA5iJqAei1UT9ynpYZCYW1FBDE4S6iiT/AXp03eBYMAYs4islbHYzTdWjxkP4MWVt
	jYy610O9aA5BLX3d9akiOBbIPEoenP/btcgIAsyHjodQcy7yy+GWMUxuXmUgRVAQ1Hrquj7Qk+o
	N+wI+lwtJVgJ8jSSN2tckeiesJzWSDPlrj5oSiMosNikzt1SyW06VaH1iL0Kv7k+zXo2c30IduM
	DhHYgItghFevhjIEL+YBpVbf26qcEEZ3JgMlqZ6IDtXfEuAqnh6oXDur/iRYnxK76B2+rdrCVVs
	uVGXQ3RmUakSBGfhyF4TOaa6usVwCAULOAlQknmc=
X-Received: by 2002:a05:690c:a1c2:b0:8ab:3696:d86e with SMTP id
 00721157ae682-8b1b5d32b5fmr5371157b3.4.1793145438420; Tue, 27 Oct 2026
 16:57:18 -0700 (PDT)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261027035431.1007584-1-charsyam@gmail.com> <20261027135354.149948-1-sj@kernel.org>
In-Reply-To: <20261027135354.149948-1-sj@kernel.org>
From: CharSyam <charsyam@gmail.com>
Date: Wed, 28 Oct 2026 08:57:06 +0900
X-Gm-Features: AclHuK95AvTLehgLpYDxlvAp4vsS4yVkPrgwzegsV_wexP6gryXmq4iIKOugNPQ
Message-ID: <CAMrLSE6ySuzsJJX-KXoeG49pS4ZVbNWZve1dwj1v1avAhHeEdQ@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/vaddr: preserve migration weights above UINT_MAX
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, akpm@linux-foundation.org, 
	bijantabatab@micron.com, ravis.opensrc@micron.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, SJ.

Thanks for your reply.

1. I found this by code inspection, not from a real-world bug report.
I consider it a correctness issue for valid inputs.
2. I would prefer a u64 total over rejecting those inputs, since the
interface does not document a limit on the sum of weights.
3. Given the lack of a reported real-world impact, I do not think Cc:
stable is needed.

Thanks.
Daemyung

2026=EB=85=84 10=EC=9B=94 27=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:54,=
 SJ Park <sj@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hello Daemyung,
>
> On Tue, 27 Oct 2026 12:54:31 +0900 Daemyung Kang <charsyam@gmail.com> wro=
te:
>
> > DAMOS migration accepts an unsigned int weight for each destination,
> > but sums the weights into an unsigned int.  If the total wraps to zero,
> > no folio is migrated.  Other wrapped totals select the wrong node.
>
> Thank you for finding the issue.
>
> But, is it realistic to have the weight_total overflow?  Have you found t=
he
> issue on real usage?  Or, theoretical?
>
> >
> > Sum weights into a u64 once per migration walk.  Keep the existing
> > 32-bit divisor path for totals up to UINT_MAX and use a 64-bit remainde=
r
> > for larger totals.  Add KUnit coverage for the actual summing path and
> > for destination selection at the overflow boundary.
>
> Do we really need to support that user inputs?  Unless we have a very rea=
l use
> case that require such huge weight values, I'd prefer not.
>
> How about just clearly notify users those are invalid parameters?  We cou=
ld do
> so by adding weight_total overflow check to the central parameters valida=
tion
> path: damos_commit_dests().
>
> >
> > Fixes: 19c1dc15c859 ("mm/damon/vaddr: use damos->migrate_dests in migra=
te_{hot,cold}")
>
> Should we Cc: stable?
>
>
> Thanks,
> SJ
>
> [...]
