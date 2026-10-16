Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7147206E
	for <damon@lists.linux.dev>; Fri, 16 Oct 2026 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154118; cv=none; b=KWefKB2P35HmBgd8IYV3QjNf+YT5smU3Os+/lmEvFphXZx7wkEcZ0FklrsdUJ0FWGv9PEH7qsyDL+xgYYMMCxSMwMTJWMsnCUPWrFb70k4iUGIkSevNXk8P3YnU0Fqyco5fBVJSvjJXCTBtf6RyxRfNgNr/j2ktqxl43UTtbNZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154118; c=relaxed/simple;
	bh=cXn/JAAY5QHO7gSOwDgZG/1D2SkKrfxhPsylIeP28zI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ZAEAJxFZMkkdsRrGB8YuwrUFczggl/DAOfcneFveFC/AWacYjxyEqWBRvyDAA3QJpAsCSOT1kqJ+LAeqmJ4qef/ZJsmr9PVzqjClQPRJf5Cc8dcmR+z5oFOjTGzimzTk0K8YunbGSztGbmTu9gLdMYUVo9DSTPcVcpvmlOrqEHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LayD7Eyd; arc=none smtp.client-ip=74.125.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LayD7Eyd"
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cd6035e2789so267278a12.1
        for <damon@lists.linux.dev>; Fri, 16 Oct 2026 05:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792154115; x=1792758915; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HVfYgQsMCF8Qw1/e6sPegSr7q8k8sKUP9Wx/2uIXt/8=;
        b=LayD7EydvarZxX5pe1FCg8HZqIRAxP4zUrUEKAbDe72rB4PTrVEqQS+cWGNStU8jlX
         vVJvYeL+IAz1l03nF8GKI51hsuD88bLj+sXsgb+wc2lcx5+Hw/iqspOVa8ldST7GfB/A
         uTCpUy09djXULNYjbd2oWmPE0acaywcMAA8J+ykDY68J7m3cPXk4N5AcYZjeL6boTjn6
         r61ICnnRw55H2Iv3nqROX+B9Ty5H/J9TYMROMhknNCPZ47+UJZXwUcZweIHHIery57o6
         YlXkquocsfyn+0He3SEZ6jYJDcm9vbZZoH9arOO3QPMXrdtzuU2rs7f4LBCuzJT1Rtm5
         LpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792154115; x=1792758915;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HVfYgQsMCF8Qw1/e6sPegSr7q8k8sKUP9Wx/2uIXt/8=;
        b=bQpUs1+66VIxIlHdwnY5NLahaF9CWRKljuAs05RwYHihkKnO9pjeFewn0+nehLKi0a
         4OMUSfl+BfZkA3F14DQ8V/rx9KxvU3x56Q1UcIaveB9fBV5O6jK+lvFbgVvkY0z1UVh4
         FAJAY2Zk4R4bEOqJ1KU54qJtioQ7hJq4jP4K+vtHkJbcDmFACOJ5V9muXWRo74Cn3bSK
         WE7Hbq4UZWLCJhqBEM8BEF8uG1XpjEmmDKJK/Y7fZaeFVU6oIwUn3t7Po79AmK/BqFaD
         Bd1IxYAs+lJQ2CfBO5dMzWozy8vEGmycYFUH09hxFAwRBDKF6EnWBu4Oxw+GVJmVLLzc
         U6+g==
X-Forwarded-Encrypted: i=1; AKwUvByfRFibTZDMXPhX2BufmE5CvzKQxA64FemdeL50UCZx+iypmo36Y7WGO8DocG1Rsbp5o6OdNw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIutOkUT1bldlF/zzIpNlct/GsQ/RNQxzYM1l7Ed06dv1nfGWbU
	shS/4gGZNwcKBR+a6TSyKLeAbrtfNn6gkm1mlDwOFp++E2hCAAGnCQ4g
X-Gm-Gg: AYBFou2vOHEXjyPq9zgOo7udxC5ixfAEmKAbm+ercIU03JslAYaQr5o064wsccQRjgQ
	9eTj5hLXM6E4xBAetMDc1/bnddrTfE16Dnhsrbu/dXZatqaGTzwdVBUZxKawajz/BXRZP+t8uPh
	MViCBOkWi37TQwf/QEBwgQMuf6l8FXuHHk8Fidnuik2pNKygYIyFpvsPkC5Qsa21zAJ5Nybem5m
	u/mfXJPw03LZRRU4S/MPg8YdB5vCoF5zV5W/h/mT3laZEPwJqK+xXc8jcmEtHu3njEu22dOpOm9
	aaO8oTWE7UST89MOOehsWs/eJVp/a9QOAaexvaJd4ULIbaedWwJfJ0TMF2QGgMONI19OI5Kuod/
	6+CRX+AzKo3OB4BNv3ifruZtKc+uipKW0buhHdSPU+bxZFCo9aekNRPgzJqmdz2+/Jn5EP3EAFt
	Uvk01atnOaYF9Ry6nYItShd4YvmL5DuOSVjfRlYpeHd8q6cPm6rN4Rodv47O10ufHf6I6Oyfd52
	tFXNKdzcAb5GUDNxRJm4ii8MoOb/8UesJdCugGqZmT4zeQmhQy5T/u5pXqo7jnEt/4npCgxyj2n
	zw==
X-Received: by 2002:a17:90b:4d8e:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3acbb8bf8cfmr2230412a91.37.1792154114934;
        Fri, 16 Oct 2026 05:35:14 -0700 (PDT)
Received: from [172.20.10.4] (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc4972fe6sm4162850a91.15.2026.10.16.05.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm/damon/reclaim: improve grammar and style
From: Aveline Noir <jm5905938@gmail.com>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261015080623.808458-2-manuelebnerli@mailbox.org>
References: <20261015080623.808458-2-manuelebnerli@mailbox.org>
Date: Fri, 16 Oct 2026 20:34:51 +0800
Message-Id: <179215409165.864368.11903228864381211337.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1792154097; l=2627;
 i=jm5905938@gmail.com; h=from:subject:message-id;
 bh=cXn/JAAY5QHO7gSOwDgZG/1D2SkKrfxhPsylIeP28zI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgboJ0y2WZIrQV0H4HJI1WEQ5sxS6pM
 Nc/XEYGLW8ee6wAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLmlhrl3kquPOrFE+xeC/g7LLIxZBSwDp24vLbGOb7+M1Qt1DRDethJgmuvu9LttDVtPsNydeRW
 aZIKr2ijYEAE=
X-Developer-Key: i=jm5905938@gmail.com; a=openssh;
 fpr=SHA256:oSxqik6Pl1M8EjQW1QXKHoylm1jy0sguOWFFJlA9zf0

Hi Manuel,

A few suggestions from my view for you here :)

On Thu, 15 Oct 2026 10:06:23 +0200, Manuel Ebner wrote:

> @@ -30,12 +30,12 @@ guests could mitigate this problem.
> -DAMON_RECLAIM finds memory regions that didn't accessed for specific time
> +DAMON_RECLAIM finds memory regions that weren't accessed for specific time
>  duration and page out. To avoid it consuming too much CPU for the paging out

"weren't accessed" fixes the grammar, but "page out" still doesn't
agree with the subject. How about "DAMON_RECLAIM identifies memory
regions that have not been accessed for a specified period and
attempts to reclaim their pages.".

>  operation, a speed limit can be configured. Under the speed limit, it pages
> -out memory regions that didn't accessed longer time first. System
> +out memory regions that weren't accessed longer time first. System
>  administrators can also configure under what situation this scheme should

"weren't accessed longer time first" sounds a little strange to me.
Maybe "Within the configured speed limit, it prioritizes regions
that have been idle longer for reclamation." would read better?

> @@ -88,11 +88,11 @@ identifies the region as cold, and reclaims it.
>  sampling and aggregation intervals. The auto-tuning aims to capture meaningful
>  amount of access events in each DAMON-snapshot, while keeping the sampling
> -interval 5 milliseconds in minimum, and 10 seconds in maximum. Setting this as
> -``N`` disables the auto-tuning.
> +interval to 5 milliseconds in minimum, and to 10 seconds in maximum. Setting this
> +to ``N`` disables the auto-tuning.

Maybe "between 5 milliseconds and 10 seconds" would read more
naturally here.

> @@ -113,8 +113,8 @@ quota_sz
>  Limit of size of memory for the reclamation in bytes.
>
> -DAMON_RECLAIM charges amount of memory which it tried to reclaim within a time
> -window (quota_reset_interval_ms) and makes no more than this limit is tried.
> +DAMON_RECLAIM recordes the amount of memory which it tried to reclaim within a time
> +window (quota_reset_interval_ms) and stops when this memory limit is reached.

Agree with SJ that "charges" fits better here, since this is quota
accounting. 

> -While keeping the caps that set by other quotas, DAMON_RECLAIM automatically
> +While keeping the caps set by other quotas, DAMON_RECLAIM automatically
>  increases and decreases the effective level of the quota aiming this level of
>  memory pressure is incurred.

Maybe "While respecting the limits imposed by other quotas," would
be another option I think.

Thanks,
Aveline

