Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE981F130B
	for <damon@lists.linux.dev>; Thu, 17 Jul 2025 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760479; cv=none; b=Pcux/9dxIxYuedtZS7+IVKLONQEjRG/CyHKBT2cPeGyf7vjTj+zYZKZ8r+cmlUKYQ65n+dA3ReYi89d8WGt5pLeEGaJk4Ug8OaASxqBhv5CbhoQXmG3PQ9QY+vMvdU910dN6WZSPTDoBqLeMjptWm41vRF2/wXPX5oaintsLa20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760479; c=relaxed/simple;
	bh=eF+P4f19b0QyAl7TlGhMccNo7dMJbWQmVvtTDedLGao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAFR2eTZ40bc9HrQY3gCdu8DcWxLhTu4y2Oi6NCg9C95BKRlDFaEhGswRXefGO6Hamz3ikSrkco+rr3NtXfs3wOQgkg1AlDmgYUCXEg/mMceQPKiJyW4LQ+eze693n1lnBYo6U/zTLkRXQ4x0B0JbDCxzfo8Rs5Vi5NpR/HiBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnc/oU2Z; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnc/oU2Z"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-710fd2d0372so16378927b3.0
        for <damon@lists.linux.dev>; Thu, 17 Jul 2025 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752760476; x=1753365276; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE+lVLd28H9PV/25rWHSLkzfrRbXfoqSo8ScR+iaAiE=;
        b=cnc/oU2Zg5Jg+lCZupuQvDEmNlCE8OSuF4k/t9p4cNuxAasr/WAzuIBZadoR8l6rFK
         8Nw0ZvHw7I//ZhEeT3Vwo03mLdXzXSv6ldOy/+eZckrdFK39rfdIAmdwk25ESQxhH+Cv
         AQC3WtUxy862+OrL9Sw5GyM4+aMEbE7PrzXSsw9ZUcjnZ0Tx9LpOnEGEv0q98q1g44AJ
         R9vtXk/FkjYtpzhmyiva+NKVwy+SjpC4Jltwx6mOZsmYinAiVzZDJ4CtFUbxsl/yZdVs
         aspnn3OczsFBreVedFXLsESTtBcRN0V9P0R6OXS1CJIv+Q+EsJXmbCcS40s6G7G0OoZh
         3lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760476; x=1753365276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SE+lVLd28H9PV/25rWHSLkzfrRbXfoqSo8ScR+iaAiE=;
        b=cMhKsuBXqxUHELc/SUY4gGYohR6hOkSfbH9kkML5De7+FIcP/KO6Et07yLgqS6D+2l
         J8fLyAGK0eEChZMlDQ31ykPfDMaRaMZDNkcQMJ+KGT3h0D5t9RHk97uWtVkoDWPFTX3b
         Bwpcgb6ofHLjiwUKvHnYXkjgSBmIDzaxdSpdoCAzrV1nmk/mikz4YVOpv4fk21eBs2HN
         RjHfE46envtGb8ISjQKjeonLSY6Oq2i5OtJY7kc58ojAnG1uO/D5N10Q8wSuj8Gnqsak
         xJBJ4XiFGh6FNfgjLPV7jRWFraJuyfP3xRKXbhItgLWfdS4UKSjC2hEWTfXn1qMH66gV
         Yp0g==
X-Forwarded-Encrypted: i=1; AJvYcCX9lc9DvVsMOmTqikppFUaBtxiwMdqfBr7OMH/5HJbR6bamMYGnCvDX1VPEqViw1GPWVh+r5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqEoOzmiN0A07LclXxEh3Ej9QAuuAn4xLCqRdk/dAZlHBHBvY+
	0/SYkiWzGrRKNsybSInlDf8LC6rjMU7fKA5rZ1ZPFlL5uBcWbPvc+/En
X-Gm-Gg: ASbGncv+kDSVbw/aAjKqGFrhuDIgP4NXcXmSB1KLJVgrkgAipcK23Bxqus4ImgzVvp3
	bUdtD0yajb+e3jhp+w23W7/JUBr4t4Jqj9lMIm7YB4OFhfThXLzrZsO8/bUQdeRyCeK9IAyOAe1
	T6tyP+82oRLB2EQcg8fazYad+8gOtEvvg2qQxajYOvUhcFqzW+m8R+73TG3FrktNiVOqbw7uSF8
	FYYwZwhjFaOl8zxJT1ihJo0jhIZi0RNjduZIawmvfqB2uZyFV/xOY8nUxl3Pz53Fqe0pCZXMfcW
	LAUmY34FmdNaabhKZQXs/ujFq75YQDlnXjcMXRfU8ngi1SRU9smbdmDkRj+eqFyeeb6EQDvJ8Ft
	Rg4cA4BpFn/M5X8JWwtva4w==
X-Google-Smtp-Source: AGHT+IGJ91zBhJRwn6R01ikOQLvXOIZU1TaryxbQhyFlluCHcWDeWQFq1vpOp0wNRV7XN0ii9tlhow==
X-Received: by 2002:a05:690c:4884:b0:718:38c1:5f92 with SMTP id 00721157ae682-7184f8401afmr49291087b3.20.1752760474983;
        Thu, 17 Jul 2025 06:54:34 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c620d5c1sm34242367b3.109.2025.07.17.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:54:34 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Enze Li <lienze@kylinos.cn>
Cc: sj@kernel.org,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	enze.li@gmx.com
Subject: Re: [PATCH] selftests/damon: introduce _common.sh to host shared function
Date: Thu, 17 Jul 2025 06:54:32 -0700
Message-ID: <20250717135433.2113596-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250717091902.104466-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Jul 2025 17:19:02 +0800 Enze Li <lienze@kylinos.cn> wrote:

Hi Enze,

Thank you for the patch! I just have a few comments about the patch.

> The current test scripts contain duplicated root permission checks
> in multiple locations.  This patch consolidates these checks into
> _common.sh to eliminate code redundancy.

Is there a reason we named the file _common.sh? IIRC there are no other files
that begin with an underscore, so it might be confusing for users. Maybe
remaining it to damon_common.sh might fit better with the convention used
by other selftests. 

[...snip...]

> diff --git a/tools/testing/selftests/damon/_common.sh b/tools/testing/selftests/damon/_common.sh
> new file mode 100644
> index 000000000000..3920b619c30f
> --- /dev/null
> +++ b/tools/testing/selftests/damon/_common.sh
> @@ -0,0 +1,14 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Kselftest frmework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +check_dependencies()
> +{
> +	if [ $EUID -ne 0 ]
> +	then
> +		echo "Run as root"
> +		exit $ksft_skip
> +	fi
> +}
> diff --git a/tools/testing/selftests/damon/lru_sort.sh b/tools/testing/selftests/damon/lru_sort.sh
> index 61b80197c896..0d128d809fd3 100755
> --- a/tools/testing/selftests/damon/lru_sort.sh
> +++ b/tools/testing/selftests/damon/lru_sort.sh
> @@ -1,14 +1,9 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4

Hm, I think factoring out check_dependencies() is a good idea, but maybe we
should keep ksft_skip in here since other checks in the script use the value?
My 2c is that it might make it unnecessarily opaque for others.
Same comment applies for the other files as well. 

But I will let SJ comment on this more ;)

Thank you for your patch, I hope you have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)
