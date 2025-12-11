Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C29B946A
	for <damon@lists.linux.dev>; Thu, 11 Dec 2025 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765440802; cv=none; b=Pek0hKbRfKLSUJdm/08JHDdCxKqWlDuXYRdc0DoMt761WhvFXKVOhkMKjXBi8s3GwfqtbGrtlYTmSqSsjFqO4XE3QGT+ecMCDWOnQUx1PsuL3sSiJVug+iXpv++NQMzAU05tgMbt6HRfpF0HlTl6JKFFxMWyWptCzjjVGiIOgmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765440802; c=relaxed/simple;
	bh=cHT4hVGuhlbX6LDgytq5U4B+HsZLo5Gsn0u9dRrYlQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pELjXcpUyZKqaSFSXSjH3EDA7pMc8uNBe3ng5wIk2LNzOh0tecnf3FlRUtOMkM36CMpgggw7bKjRebM4pBbLd6HgOT/dTXfscGSx/VfwOclSEm/2KNXS3NFsh0gx5+QS8uEhBFJHRty/rQiU9fzmRG/QQz6oKZjOlO3LdGJyYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxyIcQxr; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxyIcQxr"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-787d5555274so6651097b3.1
        for <damon@lists.linux.dev>; Thu, 11 Dec 2025 00:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765440800; x=1766045600; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CLn0iw17P9OFh9gdKJAm0SUtjHBkJ1vLAEufp25TC1g=;
        b=CxyIcQxr4mWm4Ro8rdHp+sQNfMQxwEwE6pXxBHKuLCnhsjPbGSfd+xOMQJXldp6v60
         1ByYmW/WM3ZxvnDP88zY26lEo5gyYeDvT3hxTMVpqvh56ffZIdS9f1OpFvAEAXWHAYPk
         q6QY0CTb1XIDu8kfBGseYvxtt9aEQjIcAbEeFKOq/m6ByPYm1lVS5g/dGoCcYRNrYQjE
         N/EFBvHU/Xu62AizTAMjdlVfMTVEEtK+nyYLzcLQFTyKnteZSAfX4rsJ1ovMPuWUjUZI
         tLt7znMKXrcHsFtldFUqkWbM6J5OOnTkp17b6DucS4X6xcouxm4YWxs56uBdZVs2EXTu
         86VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765440800; x=1766045600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLn0iw17P9OFh9gdKJAm0SUtjHBkJ1vLAEufp25TC1g=;
        b=QOEDICONFfAQ4AzSTtfyihMT+cwH/nYNRwhz66v21l6nYoip/U+8V+ZN1k3Z/4OTE1
         bNtcQ+yw3bq6/MJEKT+n7XoW1kkTEOm8vAk6JKoEYwPL2O2LjY6+XsXjS6Dm1iDSmS7n
         IUzHxWCTnBFQcorxx1IZYjHhttw09GYjYOLF8FkvKwneZA83/rSzpc2p77OovsOBjMg3
         E3iN+e8HqWY6ZoA2Mlgzg3s7EXazIXJV5oqIRp86xAUawB/gSSpJ+R0Bg0FjzElTo8qi
         LePgaUV+EFgRtoW6+tpL6itPy5UN5CG0PzxrWoozjkRwm2WI5K3OPN1SLLXrtIk7J/j0
         IBjA==
X-Gm-Message-State: AOJu0YzjU9F1/QbaP5PWQsHQqrwRIaal/9TM6b3jzBK6n23BE/S6+Vne
	ypbpElf7Pzck/aqYB0qDdlFJB5oHgGCNONzmSZepP5tEx2sMcRyK5ubAejBopadMF/iNJR/TlnF
	CD/Bpz5RQFRZqvZgwPf9hd3LU5dasRA8=
X-Gm-Gg: AY/fxX7ZOJVcoMh2SzbofsccfXoW/wZsbm8RMm7CdTiEmk9JALdTuW79hF3aL2aiujM
	qHcsG9JlqBOII13dDI8SPqK+LKXBWFTczt9pV8lvatg0UJ/BerrK7aP4wz/GX1cTOdXfWSeEI4Z
	AyTaz9q61iZLtPD2vKsUrgVb4wsk3pW/wli5kewvwa1Chij1rQEZCe5G1puunzaOZpmn2Z5I1dh
	EzhhYFZLFfK4X4fg+XWSBIGvW6wNRJmUi/Q9oZNE50QT7Anra5sGb/P8aAxTTiW+liNtaLw
X-Google-Smtp-Source: AGHT+IH7g+xosGzrVH4LSyMQe6QK6+GGm4lxB3NTXCs6NxPvpAP7+S/GztIodY2SbXRYMLbEGLmionhWVQVmT7iUV70=
X-Received: by 2002:a05:690c:4c10:b0:78c:57e6:6e60 with SMTP id
 00721157ae682-78c95a97b0cmr40362417b3.9.1765440800082; Thu, 11 Dec 2025
 00:13:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC7epLcuK-58kaROWMof9dq3ZCm2WV218KGv7kcDMf7q-Q@mail.gmail.com>
 <20251211075446.75355-1-sj@kernel.org>
In-Reply-To: <20251211075446.75355-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Thu, 11 Dec 2025 17:13:09 +0900
X-Gm-Features: AQt7F2rdWXEOoWpuHS2_yNXMlB4_wOzvOZ_YEs72z7WPudcsREt6WXoUBNFbR1E
Message-ID: <CAHOvCC6ixeLQeTJANkAvQhRviLyr7=xNBs-_jeKEo+qF6E3qAg@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: modified damon_call_control from static to kmalloc
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 16:54, SeongJae Park <sj@kernel.org> wrote:
>
> On Thu, 11 Dec 2025 16:38:46 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Thu, 11 Dec 2025 at 15:04, SeongJae Park <sj@kernel.org> wrote:
> [...]
> > > Sounds good.  Would you mind sending a patch for that?
> >
> > Would you like me to send you the patch with only the comments corrected?
>
> I was just asking your preferrence, and seems you have no strong one.  I will
> do that on my own unless you mind.

I have been argued the following so far:
"I proposed unifying them into kmalloc()/kfree() methods and
removing the dealloc_on_cancel."
I apologize for not being able to respond promptly and smoothly
this week due to a busy my external lecture schedule.

Thanks,
JaeJoon

>
>
> Thanks,
> SJ
>
> [...]
