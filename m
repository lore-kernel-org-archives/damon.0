Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E7937BE8F
	for <damon@lists.linux.dev>; Mon,  9 Mar 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069606; cv=pass; b=aBQHtmBAvOf08t4SQ9wEAvoDYxb0qpTOyb2PrZ5ArZBOU0EtQg06fo1t9gxCSReuwUPVvyzOM8osFbqGFE/tUfb+sBlfmkg9S+uFHeEdIWO0yQLjkL81sbLvgdwY5jtAKb9RYKmUclgGFRY2JjJ3P+I3SBIyNXPdMXCXvgm+Vj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069606; c=relaxed/simple;
	bh=z6L5lDT6iJVMzgmGHw8+z2qnP+1bKb5wssYVFGZee60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4IZnuSulZBNfAojn+XUW0yeDSW0mPlU0fZO2UiDMquj1rXe4nIjOFPJdwnaa+X2s5r30/4WYHRNcNKRKn1rDYj5bmYlI6oHKpcDjo4IVbDUR2ZqHvW/INVJsmLQIaJDFp6I7iIAdWJKqgCqWkdO+nOtHAfg7RgFGPOuhMMGFa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNyDp/L5; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNyDp/L5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae523d54d2so146325ad.1
        for <damon@lists.linux.dev>; Mon, 09 Mar 2026 08:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773069604; cv=none;
        d=google.com; s=arc-20240605;
        b=Q3nv5FlxDMz3kdBl7mlctjOhppHDRUBZ7gCJkB65dwgATj7UJk6e0ldu+JzG5FnAu8
         9FaN0WpYvDAC00A5IHOqx+xtnOemdHyF7wvc8XJAtUb1hey+7f4AyJXl5Ub0UVcOHuh8
         953PbikUAaiP1D7WdOgH/qYIXBkzR+ZIS050Ap28BkUGaMZyMjAwrebOWbm+yTcfwZKV
         URm0+Cx1v0GSIVf+rAoKPqBos4hpbCJFIYJOdgcsYkKIgt/aXzxDfQf8s3T2IvcE8v80
         8d0ZW25KoN39VyWi2ZFpjPlwlEIrDV5latwyM88GjuNAzYEI9L7NY1EVubS7LqnMJbOg
         WLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YCwgn/LGLbOqI0PyvUZQbnycgUxHpuGNhHts7H9S6JI=;
        fh=Qn5HXEqNjJtg0nPfSMW39DW7VbZmUwNfyOaEMo3+uC8=;
        b=Sdtw+QdDPWD8jbm0uVP+4g4JCTpL4zAzgsaq+Vq8oC0ZExG5GIg4KPesiZUWLD9zpk
         lBrCpyCb/+/Xu3P+On8uSLuG9bqGYLiBcwwLTYrhmqv9KTgIu6J5nQm3TEBOf2R9nTud
         55KA0GMUL4e5DgefUa2apapOdxG50zW5sjsRh9MKQZxzmG5Sb0hQxDGEBc0lM41QQgtp
         HKzOjro5EeCjLA2m9sCLuN/U2ua2AbKDFVyyUBz0C6pvEILHltd+Uy2fCD2xwLxtIMJ2
         LIAiYIddG6eUpng+bQnUzdrI3N02eD+wrOQn6eoQUfCNccKKBjWILD4xrSRIe+Tf98WH
         RzFg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773069604; x=1773674404; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCwgn/LGLbOqI0PyvUZQbnycgUxHpuGNhHts7H9S6JI=;
        b=VNyDp/L5dPQzuQF6/jQC8v6e+FKaWUCXglTeqLkC6Y4b1uFF+MGezYS+3hnH8U8CbK
         9cvpBlz/b80eBWrXcyvZeWA65YigIUQheWNuUAA7M3LmmVMyf7nJxWszXOy9J+SChuCf
         eIEkn0NV6BAP0X2ikCXXdW+0zjTqQ16v4KRohfvFMeNiGSLsBiyTWB+moJzDKPbqnAcF
         mSlc/jr7r782DcvwyUHCE2nXlJjsqFSsDyebOx/Wsk8/AvMwyeefnrDmFis4HhycL82V
         syP9fyKBxNvZbJqpPgXY3JgCHUFFmQsPgyj+uitVVb0m8sHkFxMHzBvfJYKELHZuorsQ
         uTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069604; x=1773674404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YCwgn/LGLbOqI0PyvUZQbnycgUxHpuGNhHts7H9S6JI=;
        b=BG/nTy6XyHe7lMoITSOZXBvdQBPDCYndwNVPjNibmxQuLlP5cv//2XTzG4CkwBOx9J
         bDs42eOmBFC9NgAiugLYiPqoUUAMazBF0X3hBnGPG7IDJXNkMSTp+bBQj5dtNL5xKCWb
         LduXisq2+3jUgnXU7mwi/iyPtNN+/GZViVG8xHkdXLo/O+VgZ2uShVQgwnBXbUHumJqu
         vNp5H/HA0tYLuQAsSamI+9eSqL80uQk7ALk5AqxjaZd6RHPno+r1vGjGGAitTsgPe62z
         CS3egRerzClL8KKi3GiR09l+tY8iyRyDwrZBhdnP4ihPLkLqUPm5hT5Teq3usVw8YJ2X
         zm3w==
X-Gm-Message-State: AOJu0YzdBkVlNM0QlN+V4uRZe7sE+gOFkL8vnWFBXb89ZC58141JwKCJ
	FIaLgu4AD3S9cfPzawIBILRIsNbqX2ZFzye/1cBxD/xD4XUNAvPsCnTCzTBRekR/HMCUeQPcbwk
	GGqewPkDi91VenMn2t/V/uGOV3/4M3tNhQYLfd/Hm
X-Gm-Gg: ATEYQzwCXitRue2mGOschH58IjF4uyhhtdPfOje+GLOHp4MSHwyJi3hFArrtHeYuyXZ
	GBzCKXkG/1XKRuRvhnhlDhRg7Om3TGvbhuxVgYwUoupZsgCKDuAwwGvOKW0Lw+300FQwxx2meO5
	ehX5l7nqgaKEoI4Lf1utbtAdxjOQGkBXDHpgQkrL76zd9tLG1KdsQvpakxIJpVUTqdwT3J08ICE
	JKAzI7L2J2n1oStsahY2C3ua75x00xjxh6+vXnWEwMygpGQUTyUrXbXAibA1Ek981O7TU238igL
	UDfJILzcP3UmKlwNy8FK1G3q3LYvgBklfO0QKA==
X-Received: by 2002:a17:902:c94b:b0:2ae:57e6:616a with SMTP id
 d9443c01a7336-2ae8acf04ecmr4622815ad.2.1773069604098; Mon, 09 Mar 2026
 08:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309010009.11639-1-akinobu.mita@gmail.com> <20260309010009.11639-3-akinobu.mita@gmail.com>
In-Reply-To: <20260309010009.11639-3-akinobu.mita@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 08:19:53 -0700
X-Gm-Features: AaiRm53lVlx387A0SrY6zRXv10i_r0OBQERaDBdoHzQAntDt8AQ7OB52dy8QI14
Message-ID: <CAP-5=fUPWNzFvsA0T3xJdGa1uQ2QgnZyphWys6AeFZNE54WXLQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/6] mm/damon/core: introduce struct damon_access_report
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 6:00=E2=80=AFPM Akinobu Mita <akinobu.mita@gmail.com=
> wrote:
>
> The struct damon_access_report is borrowed from SeongJae Park's
> DAMON extension project [1].
>
> [1] https://lore.kernel.org/linux-mm/20251208062943.68824-6-sj@kernel.org=
/T/
> ---
>  include/linux/damon.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 49d2983af4a8..5f2870ae02ba 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -110,6 +110,30 @@ struct damon_target {
>         bool obsolete;
>  };
>
> +/**
> + * struct damon_access_report - Represent single acces report informatio=
n.

nit: typo s/acces/access/

> + * @paddr:             Start physical address of the accessed address ra=
nge.
> + * @vaddr:             Start virtual address of the accessed address ran=
ge.
> + * @size:              The size of the accessed address range.
> + * @cpu:               The id of the CPU that made the access.
> + * @tid:               The task id of the task that made the access.
> + * @is_write:          Whether the access is write.
> + *
> + * Any DAMON API callers that notified access events can report the info=
rmation
> + * to DAMON using damon_report_access().  This struct contains the repor=
ting
> + * infomration.  Refer to damon_report_access() for more details.

nit: typo s/infomration/information/

Thanks,
Ian

> + */
> +struct damon_access_report {
> +       unsigned long paddr;
> +       unsigned long vaddr;
> +       unsigned long size;
> +       unsigned int cpu;
> +       pid_t tid;
> +       bool is_write;
> +/* private: */
> +       unsigned long report_jiffies;   /* when this report is made */
> +};
> +
>  /**
>   * enum damos_action - Represents an action of a Data Access Monitoring-=
based
>   * Operation Scheme.
> --
> 2.43.0
>
>
