Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8B1471420
	for <damon@lists.linux.dev>; Fri, 21 Aug 2026 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306138; cv=pass; b=Y4A3GxPHBJLGCJ+YqcKgMDp0lkz4RtzW3GggkWcXfyIp/PwoCd8OWtutHUGnAx0UHdWpDumE7f/5BIyAWiVWYg1et3yjFGmIGAeX7PTj75d1Dd9g8ysWxQPW2uljed9tCR1astN3O3TGLMN2ZRXynmA2toog8REsIUjIiMyW+qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306138; c=relaxed/simple;
	bh=XyIuSqWOzg847lGxsHuF4rkjnY+0QJdXhS5NihM+L/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNb5a/uVCQ8tfkA6HJQh9th2OYnUpJtotxui9xmW3cGc8JyOv8WV9YrvLhqmbjL4rC4H8gxyhKbR35M1pxFEe4mQVNEIPEic2irWOM53W2cwVPYCSjtT6CNIn+TeVx67imvX9BpHOVADiEC12gEzi4tUs8N1U7HTyYJcFV0A6bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca8PNiUC; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca8PNiUC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-499b57cf2f3so4567315e9.0
        for <damon@lists.linux.dev>; Fri, 21 Aug 2026 02:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787306125; cv=none;
        d=google.com; s=arc-20260327;
        b=GDyJ+4TCDz7HdAQC8bA3+S8F/WhXr5aX7mSe+xsKHdzIXMlSBeF7CIp/oE9DOqAPIZ
         V0jqXNliejqAvLVlzGgndReTY04xdRswLb2NpfaMT+php2Fkkw8+IffyJWrwR4gS79i4
         IeMvXMHaOVLN9re/pe4mbiryO5FZRXygbz4jUJ7K0WlvY3X+WzSOQ4cRHZ9iizvtzZ3d
         sWJdHMib7Ee8hm33cfNs8Zhk3VP6uy0tENdF3UosiNfc1gKe7tESSiaBkgv6e5ScK3Vc
         xFiWGTe1svNJ8+Am5tZn/XtGvJXkipqYSR7gO6KmD+cRHg5daHXTpfhpA9BGSOlBZ4M1
         RGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BebempJ9dvkwz+WZ53hR+1ZE+ffzaH6TRYMnpDAc13M=;
        fh=i1vB4ZJoJBEIIPjMAxJVa7C8XX0r4aITks1MKJcdr1k=;
        b=R4nH7WERxLDYQumShG0jvGWHeWbZN8YxCGXa9825CGx4G2QJYIilCHHL22WsBjWNb8
         192IQXj43jlsZk61J3n1VFHhBAYP9ppbDQvmosJDzW8QgLAAduUlaE9zXeVktWek2zFb
         6utmhSBUF/to0pjLkbgqcA54A3VUkd3rjtIvDvNyyJXgMBwy1ovE9MPna1Rn/CkWOsXp
         QKRc65u3XNQOjG05AcdxEqOAH7+xJFHPHSkX3uAeeoB5aDdF+s14oi50KG/ZT1JXcYdF
         xbaFBEUO+XcbO+DaLKUb2Q9w0hYFMKBAx7lIFtCl6U313hZ4rJn12xj0UOQRyDdLf9/M
         rN/g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787306125; x=1787910925; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BebempJ9dvkwz+WZ53hR+1ZE+ffzaH6TRYMnpDAc13M=;
        b=ca8PNiUCaxeLe2/t6XiDZFVsqEEAnFVuaBvpNQulh8LF1EJ3kCaZyBgAfjl80+2Jq2
         w+q+iUArIpZ83haPuPj25je6eCLWcCjFaX+hzCGMjhzAOj2RD5PI0XnMJaFdPmD6cSL+
         +628frpI4H36iBjF5hhGknipVKvXjabCx1Mj2rNmqOt5KIQJz0cWQJTzZlPa5uu6vDa6
         ej+I3GXO0sS7sfMg3NkxR/WVH4fH9cy8AkECIGp5OUEQrODJfZj9+pH1YjXLgrU8deiC
         tKmv+9DzvcJCsvZomtvdySz1Eb58t2p/Tx1t41/K3+6UIKsIZua6d/1AMTP/6lF5mE97
         QhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787306125; x=1787910925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BebempJ9dvkwz+WZ53hR+1ZE+ffzaH6TRYMnpDAc13M=;
        b=C+AntlPR6qrHLid+FQiPxAnjQSUp0SjT/KYV6bp3pBI3/HGoVyvVg09TVHyVa7FlyC
         oO5efHSd8h+moYzacOnxPW0vJMqozJbWtuLsCYgis/2ozIkL88QRqE2PAE26QmoENy+H
         clEazj65lMfNv+4aOOlKnsksH1Q6ptoKTcM7PA8Y0v0CbpGEbrXI6x4kdCVh/iPQOCja
         86liTffAldXawezN+5X5lujPIyMxtcx8P5LGjtkAsQ/trRonzZ3YlMnQwK3Vc/9j9r0f
         klGKuesnRfPw0BnhDioF9xhKTZ9IVIZrV354NvFSENN+hWkDhddcwDQhyeL3O3wo6jMP
         JaJw==
X-Forwarded-Encrypted: i=1; AHgh+RpiJHVvnEj5YCiNuL5Xkq4BozXBDusM3clKrEeVskYuypzqAsFH8O91SGSuLKNT7OQ8EwuTxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyioIZNflXxMJuem1fWpV4DqC6DRD7Y4GOyL8qnu/9Qpq4sAmvw
	BPgV3RMkRNeUEjbj3zJgjvETLYynBUGbKZdtORfAX3Y5u5jvyhhriwmezw3+Y1eX4UGXyjmDj9N
	XwzNy7eQ1l3pv8zsrdq8itsPs5kaYSmA=
X-Gm-Gg: AR+sD11ALHU9a35wFCJYAnhjgSl42LtpjLTu4T0ErD8sBlB8bxjDLkI9VVtbHaCqjCZ
	sf/2BsjyrHxDmG4s27c5E94xXcUVvDEs7YigLIpetFSt+g4ADJBVwLOxTfmLvfe837V1SCl1CrI
	4zQthWGg3WGQdyaTLMhvHe/kvvV/cpslb8QT42bWwa08Wg64gJwEYvuMi/M7Tal9qd48x6fmCJr
	udNKkUT6xCL/ABJ5rdpUFxegYPV2HlO3QBfwryW6eMhAGxH3ax9rasAuKHka08pdhu+lHHUwPfj
	MGh/lGM4iFhba/y9NOFv0IviQZeeCMSJvowR3ieQhjle231O19asLWyqXBOEITzAXos5OV2XV8M
	qaQ==
X-Received: by 2002:a05:600c:4688:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-499b91ad940mr38916495e9.7.1787306124204; Fri, 21 Aug 2026
 02:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260529165640.820-1-ravis.opensrc@gmail.com> <20260818073546.832476-1-kunwu.chan@linux.dev>
 <CALa+Y16xODsaFZDfh7ZeP3gWbycK92gvP5N8_NFpOvW=R2BWbg@mail.gmail.com>
In-Reply-To: <CALa+Y16xODsaFZDfh7ZeP3gWbycK92gvP5N8_NFpOvW=R2BWbg@mail.gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 21 Aug 2026 17:55:12 +0800
X-Gm-Features: AcwNN1XF81EEMAI-2sCN9DpjO0D8fvVc3wuFNPsACQIR2_DkOmL8KEG1jq8ABI0
Message-ID: <CAN_Opa_h2W1hRimy2YXPC4EgueCi2UNwnZ5gSYV=cr8M7yfCmA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] mm/damon: hardware-sampled access reports
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, sj@kernel.org, akinobu.mita@gmail.com, 
	damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ravi,

Thanks for the detailed reply.  The fan-in diagnosis makes perfect sense.

> Your series is based on the v1 substrate, and the way an event is
> configured is the part that moves most.
>
> [...]

Glad to hear v2 is on the way.  The probe-based model is actually
something I encountered while building the AUX backend. When multiple
sources can feed the same region (e.g. PTE scanning + SPE/IBS), the
question of how to combine their reports becomes interesting.

For example, CXL tiering may care about physical-address locality, while
per-process monitoring may need virtual-address attribution.  How do you
see probe weights being determined =E2=80=94 is that expected to be
scenario-specific, or is there a more general principle behind the
weighting?

> 2. The 67.9% drop rate is fan-in, not sizing
>
> ---
>
> [...]

I completely missed this.  The observability framework showed the
symptom (67.9% drop) but got the root cause wrong =E2=80=94 it's not a ring
sizing issue, it's a fan-in problem.  With a single kdamond thread
draining the per-CPU sources, the samples effectively get funneled
into a single ring, which explains the numbers.

The per-CPU drain approach using `system_percpu_wq` and `queue_work_on()`
looks like the right fix.  Our AUX backend already carries a CPU argument
through the ops, so adapting it should be straightforward.  I'll take a
look at your v2 branch and re-test with the per-CPU drain.

Two questions:
1. Is `damon/perf-rfc-v2-08-20-26` ready for me to rebase the
   AUX backend and observability framework on top of it?  I'd like to
   validate the per-CPU drain fix with real SPE hardware.

2. For the probe-based configuration, does the `prep_action =3D "perf_event=
"`
   model preserve the same event lifecycle?  Our AUX path needs to create
   and bind the event during apply, keep it disabled initially, and enable
   it when kdamond starts.

Thanks,
KunWu
