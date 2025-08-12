Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A3BA42
	for <damon@lists.linux.dev>; Tue, 12 Aug 2025 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001976; cv=none; b=N5vmTq8zLTFoGHv5h2Aq1FmH0aI73zobYFsMJfMMEbxW54qeXt4sb1yDmZ+3URj/4937goFYPd1yvROsFMS5NHT9XvxKkn+XGemi2iu1VmNwMnU9vwMecXFG6/Z1BCn0bPEohACZiIJgcy2ygcQ3K5eV+wem8mlOUL1o5MmhbA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001976; c=relaxed/simple;
	bh=4rgOB75uHJhQ9FKGjjwyzR4VYHrWoTncP8I0hzQ36Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6uDrCRRCoyEcQ7+v5ZoJVJGLxhapeQsudCOrcMkahyKIqLIJj5CMeEW7Q7SqQErFTFw3FcaZTxWPVwfMqdMYZZKDTwsshSkKT8RV7qWUTYIUkQ8X6sFBOpc9viDnWaIsOaBri6/EXHlR24C24FxM1jCejSeP1wa15Mv6i/SRBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZClO7BH6; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZClO7BH6"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-619bc5f638aso887848eaf.0
        for <damon@lists.linux.dev>; Tue, 12 Aug 2025 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755001973; x=1755606773; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJbVEsQJVCjelejxZubJqTtynOwasKvIUa9eAU0KJJo=;
        b=ZClO7BH6Oif6SgAtF0kKV7k3/1BCX1UTpxqo/yhvgjaY0Q6hvJ+x/GtO3jh7NeWZ89
         WcND3MbdlGv75V+dAT6rsaH+bIyj6MdORCTBdnU1XXJdCBIwAs/BKgw/+VNBpG4vQSZP
         HoWgmkVQ9gs7YGXwQRPIyBPLfgqiv2jKMAU0VcJBFw1/NHT90B0UMwb4K5LztHVFqUdm
         suAj6NeWaC/Z5I+SKVXByumHymrKI/mogzsPU9cXtbdTEFW08ZN7lfZYKjruqDpnrGek
         cn6VCf0u4xZoojah/SDfEz0hkVZuADYB+ahCcFpeAg/UnN+8e+V4AjTtZquFvtnn4e3c
         RgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755001973; x=1755606773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJbVEsQJVCjelejxZubJqTtynOwasKvIUa9eAU0KJJo=;
        b=voIgE5475G4KY4ex5+e08PwSXp6RNiy2hQyRUmGtnhaiA5POtuP5ljHKPLYEp5LELn
         dkc7CtNfJBOJ652cMd2Ibn0g/itMEBjBoSgLr1BGo1H85VvNpo0/lusQjpq67FtfjI6z
         65HNUnE490WhaqPG8VKVqbnSdc/J9oEarAPP18rkY78m1qyu5TNxThY/vLceSGryBFCn
         FBKsDMPFruJmd0IB9DfR7EYpaM0hVFxZpQyFNEvuLIuFiEltxSLL+L6lMIPUzkNwzMdk
         iUDMRzW4LtIoJ7oFwr+XNVnFtAEITdvhgwWz2sjXdDko2pY3RaqsLUxcnBEg5A0KGyeT
         x60g==
X-Forwarded-Encrypted: i=1; AJvYcCUkbknfgw+hX7zo4Q5UxGZpgsYORR64g4zBVVSddyTgZ5Wfn0EaeC5uAY/D+ZKx8LlFZIJk1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6Old1BEh0L4VHgu9+Xcx6DCXTM5EfiDgQ2llBcSzvaAfmzv39
	93zLQQ9ovAeIdlTuJFkN1yGVEQbt7CtaiK6tvbkLG5e2dR1K+D1WDgKSZh3sQRlW5rQPnY41SxK
	0vXxZOitcFQWZhXGh2JVIqIw5hAvhxms=
X-Gm-Gg: ASbGncuNBxX1BlNK5d1H97khe5fQ1Cgk1+IJ/R3sAkgWdhLgXFHxSprjz4vETlHc7/U
	oPQnZOBh8gkw6MrBaUsDwXa4kny6NwO4t4IG1MfDFI46g/inPI1gMk5wVvMoV8iXpGrBR1RHEvu
	ZvjMHLhoSdE4dWGlvxBWcPA86X0zfrrO7nBIefMlmcuvxSn3dwjtK6nzeCkJGZZmRGEZskX0DBq
	ror
X-Google-Smtp-Source: AGHT+IFLY+ky7e3BroIIydWjoY0aabZimRGPv+KZv2ff2sfoqaC+0xQ4C7oeRILPEIRw/Fmk+/4AWjzm7pUMRn5Tgvs=
X-Received: by 2002:a05:6870:169b:b0:30b:9750:3085 with SMTP id
 586e51a60fabf-30c94ed0290mr2350864fac.10.1755001973402; Tue, 12 Aug 2025
 05:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250812-alex-fixes_manual-v1-1-c4e99b1f80e4@rivosinc.com>
In-Reply-To: <20250812-alex-fixes_manual-v1-1-c4e99b1f80e4@rivosinc.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Tue, 12 Aug 2025 21:32:41 +0900
X-Gm-Features: Ac12FXzk5--95ren1VR6OqqAUzs5yqbnOkCJYlLg7DPyV4KuIMBIBIZHxZk8QM4
Message-ID: <CABFDxMGPS6LE=A25VjXEpfKuzVfgxfgu=_uhkWXc3D+xuq-B6w@mail.gmail.com>
Subject: Re: [PATCH] selftests/damon: fix damon selftests by installing _common.sh
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Enze Li <lienze@kylinos.cn>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Alexandre

On Tue, Aug 12, 2025 at 5:13=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> _common.sh was recently introduced but is not installed and then
> triggers an error when trying to run the damon selftests:
>
> selftests: damon: sysfs.sh
> ./sysfs.sh: line 4: _common.sh: No such file or directory
>
> Install this file to avoid this error.

I tried to reproduce those error with my vm environment but I failed;
with my workaround test method, it doesn't exist.
If you're okay, could you please tell me line by line how you execute
tests in what environment?
I'm also struggling with the test environment, as well.

> Fixes: 511914506d19 ("selftests/damon: introduce _common.sh to host share=
d function")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  tools/testing/selftests/damon/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selft=
ests/damon/Makefile
> index 5b230deb19e8ee6cee56eb8f18c35e12f331e8b7..ddc69e8bde2905ff1c461a08f=
2ad008e6b28ac87 100644
> --- a/tools/testing/selftests/damon/Makefile
> +++ b/tools/testing/selftests/damon/Makefile
> @@ -4,6 +4,7 @@
>  TEST_GEN_FILES +=3D access_memory access_memory_even
>
>  TEST_FILES =3D _damon_sysfs.py
> +TEST_FILES +=3D _common.sh
>
>  # functionality tests
>  TEST_PROGS +=3D sysfs.sh
>
> ---
> base-commit: 2754d549af31f8f029f02d02cd8e574676229b3d

Does this commit exist in `mm-new` or `damon-next`?  I failed to setup
the same base-commit environment.

> change-id: 20250812-alex-fixes_manual-aed3ef75dd83
>
> Best regards,
> --
> Alexandre Ghiti <alexghiti@rivosinc.com>
>
>

Thank you for great work!

Best Regards.
Sang-Heon Jeon
