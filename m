Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31987126C02
	for <damon@lists.linux.dev>; Fri, 25 Sep 2026 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318792; cv=pass; b=LAMMBJwEOT/a3KvHFaNB6UKJIfdguPFfZr+OJ6d8Nt2NNEkfscFfrk6hc6mjEROAUu+y6K0lOJ9nTCLGx4u48Q6G5oa0L+mGZDMifou74A/eyN79boM4XVM4KrhlYSN7GVWgI1cD/h+NUc+ywF7m9Vch8p574cS7iIBFU4x1ZU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318792; c=relaxed/simple;
	bh=FMYQeYmwapr9qKJcU1TiAWf7WUGFTHj+8reCqdf/NZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuM+cevcttu9dKFGkZnOtxBCnAUYbDrvZR6ZKrd1bPd8T7fYcKdcFyWmPn+7byWQ27UiWAcvRdPAi0o0Rs8/+ffLTBWiGPaL0xKEeajVVZe9uOx2IADPQj2v2QV+V/LdrwpvlGLMas3fJg+aEx/ostHNDd3jWFg48tkTRMHlNao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fp1lgKaP; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp1lgKaP"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso2171815e9.0
        for <damon@lists.linux.dev>; Thu, 24 Sep 2026 23:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790318789; cv=none;
        d=google.com; s=arc-20260327;
        b=mpOaNNrykwCO2kvEkwZ3zvyTdE/4KGxAEPxZl3NWO4Xok4yRVE4KW9JuYGJ9kQEMY8
         1jrBMRQGct/qA8XGUNjcMBmG4GGLgooFLbH5BlixhIbeVCST3YTZ9gcI4A44CSh6EorO
         acbrz9lUCAnUI09dj4jcI7aqxFcomg2pliy0m4TwIfqupcjy1EcZgUUayGisbDHNejjW
         4sZAHi7MuhPAftM3o059yhqOT29gQ5uHcyZV2Rw12O6Mww4XtKfCwJ6Bqy2A7ydyhGQi
         cgBNa/3GXO/mg0AF9fgr97t/NpeU7SKNl+LEdZyDbMSPWCHgqy5ECXLZI9j9IwjbeIXt
         JzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FMYQeYmwapr9qKJcU1TiAWf7WUGFTHj+8reCqdf/NZk=;
        fh=yuADNrJPqNnHolvX8oqa+4lf+Hl0ht1/eIGiKyTFABA=;
        b=WxhqnrU6noEQHzqMx5Clt1B5SxEf3ZL/MxT2T8bJ+xVI9OllKaUB+54lQqx0C3xbMX
         /1dp21AYg4mF/gBjlYezGaIgFI9WkDCwYsozGdSNCvWwE38n3Vq/vWvkgB997Fl+kfmZ
         OwWmsBJxfZd7Vylxurwep/QqoVin3N3A5RjipFDzPthGmyWwZM19HZBwwjRmB490fpP0
         2rEai18q6R5+2ewsCpYPEJhD5ssP/B0CbpjqgbJCSF5mFXEw+YFrG1cMR7sK1Ed1cEFD
         /tchlCMgsu989l4RGL8KXRXIHeh14sje5RzWZoj7Pl9VZ6+4xzxn6JhTgwAOjJBZIdFn
         x1/w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790318789; x=1790923589; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FMYQeYmwapr9qKJcU1TiAWf7WUGFTHj+8reCqdf/NZk=;
        b=fp1lgKaPrr8bcg7odCSFR+usaIyqYeqzLf4rdax63dhYRnoQk1wdZl5EJ4Lkt8+eZY
         pNvdCx9ggr00cGPxYSR1MUIjlN2ls662QIm1YzPF+fXwEKhJRDzWDhOF27FW/FyXj1J/
         /opVv0odC36QzoCKS3PTDJepkz/sUs6flVyi2ArDDb2oUwP3vlelXaCjITzV6v+TQcaP
         qOwmWPnZCzZ5b6pOUS0OeHWEgznjVIKXrcgKVm5HJEU6OqdLvOi2TUNNqh53AyKL96+G
         Uj1RVrThim+p7utk6O1R5iHNZszEr7siqs/dJzz8PihAlELPg/tBGTS27koH5RMZL4Sd
         Idsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790318789; x=1790923589;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FMYQeYmwapr9qKJcU1TiAWf7WUGFTHj+8reCqdf/NZk=;
        b=D1NyJjVbgqCgkVoxf4TwpoH7HXX/YV7+ZaOB3dYqzm2yHttCD9QYItpdXJ6WFqCli/
         JlpVzEBXVTaaNiK1MOouYmssqN3AJRqY6dDpXvilNod1ZJRlGzbLO/RL4dzH1VCFpq/2
         n5pqmkn1FtAMx8Ji94XkkqfkUJ6YO2Gi5a154c2Wdpm4sZNwuAk+zEHBbOlS8xy81X0g
         FmDaD4Z7AaRcxe3v+hNUMXoAD0H3SrQq6Eb5XWZAmkeWR4ZQvMSpLPXESZr5jfw8lN+n
         l6EA20cf4sfEi6caDTuJseSKhWTENikC8MJ1xSKbUy2QZ/9DRl7dwk/EBYm3D1idOYyq
         ZYfA==
X-Forwarded-Encrypted: i=1; AKwUvBzv05ctePqxltstFD0InNUV+Nt4nuRzKTIHo0hCERpZnydsWVsazx2i1QE1OH9EwXkEKfea5Q==@lists.linux.dev
X-Gm-Message-State: AFuF++mOw/oAcBWSJJUULTzO7Yra2JwZ1lrn8X+o2Jacae6CjEP25sZs
	+k3G1AtDA6iqA2Ay4fexuFt2GUxBal0/45JYcd30smPJUIT9WsNHF916PV3IroZgflIlGlJ2d4k
	Zm9tWCekz257SCj9WFLV7URqC2wrhhNY=
X-Gm-Gg: AYBFou2krXxtynEmqDB8d9Cm3GhU1z6OGQeHHcNHFVMKrhH2OMC8Q9tHzkv3BtlWFxK
	lAKE/NqATSboJxIOI0xsLwD7l86F4dAlBTEd+lQsZP0yJVOdTZHIh3KIga7HSUGWeHlKNadOqgP
	ZrGacPaZmLd8tZrvu24U/gjL0Mkd6YhiltEVjlIQQJOuN/eg7OPhXMdzwMbMFHUjjQxkp9j9VgG
	5T2qELWrAHX1I2B9iwZcQvUOJUVEO4DcfEVH2YGEnfyB7OS15g94Usct4w5k/DRccq9oXT0UYzf
	K15/zv9g7gt1yWL+Hk79RIzoQSMvf1Hi2Mq2+nFafiSDTS2QoPpAE5STs2+SZPGcbvib/ILGc+G
	vktD7AGK/ivAe4A==
X-Received: by 2002:a05:600c:3107:b0:49c:cee2:1697 with SMTP id
 5b1f17b1804b1-49ff06e502dmr21437475e9.16.1790318788803; Thu, 24 Sep 2026
 23:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260925054408.10431-1-lance.yang@linux.dev> <20260925055807.32678-1-lianux.mm@gmail.com>
In-Reply-To: <20260925055807.32678-1-lianux.mm@gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 25 Sep 2026 14:46:17 +0800
X-Gm-Features: AclHuK_RfCuOCjo48ccB0F6bBk20RwJxdVKVRfQ9R5t7EYWoxDxogjcXf0echJY
Message-ID: <CAN_Opa878W14HLKZHic415SH20dHfJQwxpaZu0LXnLMsc5Pqrg@mail.gmail.com>
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
To: Lian Wang <lianux.mm@gmail.com>
Cc: Lance Yang <lance.yang@linux.dev>, sj@kernel.org, mst@redhat.com, david@kernel.org, 
	damon@lists.linux.dev, linux-mm@kvack.org, virtualization@lists.linux.dev, 
	Kairui Song <ryncsn@gmail.com>, baohua@kernel.org, xueyuan.chen21@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lance, Lian,

Thanks for sharing this, Lance. I also saw SJ's post yesterday and
was very happy to see DAMON being used in a real AI production
environment and delivering measurable benefits.

Hopefully, DAMON and other MM features can continue to evolve in the
AI era, better supporting diverse workloads and real-world use cases.

Looking forward to learning more from the DSec experience and
discussing this with everyone at LPC.

Thanks,
Kunwu

On Fri, Sep 25, 2026 at 1:58=E2=80=AFPM Lian Wang <lianux.mm@gmail.com> wro=
te:
>
> Hi Lance,
>
> Thank you very much for sharing this and for your interest in the related
> work. It is great to see DAMON and virtio-balloon being used together in
> another real, large-scale system.
>
> One scenario we have recently been studying came from Sangfor. In a KVM/Q=
EMU
> deployment with guest memory backed by shared tmpfs and host THP enabled,
> host-side DAMON can report a much larger hot-memory proportion than the
> guest's fine-grained activity suggests. The related discussion is here:
>
> https://lore.kernel.org/all/20260915025514.2434-1-lianux.mm@gmail.com/
>
> We are preparing more complete experiments and improvements around this
> scenario, and we plan to discuss it in more depth at LPC.
>
> I am still actively running experiments based in part on SJ's earlier
> introductions and our discussions. After LPC, we hope to share results on=
 a
> more regular basis, together with discussion outcomes and reports from mo=
re
> scenarios. I believe DAMON will continue to become even better as these u=
sers
> and perspectives come together.
>
> I am also contacting the authors of the DeepSeek paper to learn more abou=
t
> their setup and experience. We hope they can join the discussion so that =
we
> can work together to improve this area further.
>
> Kairui is also very interested in this DAMON use case and may already hav=
e
> discussed related ideas with SJ, so I have kept him in Cc.
>
> Thank you again, Lance, and thanks everyone!
>
> Best,
> Lian
>
> On Fri, 25 Sep 2026 13:44:08 +0800 Lance Yang <lance.yang@linux.dev> wrot=
e:
>
> > I was reading DeepSeek's new DSec paper[1] and found a nice use of DAMO=
N
> > and virtio-balloon:
> >
> > And it worked: time-integrated host memory use fell by 21.2%, while pea=
k
> > usage stayed about the same, with no significant CPU overhead.
