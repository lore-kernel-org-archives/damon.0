Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979422DC792
	for <damon@lists.linux.dev>; Wed, 31 Dec 2025 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767162244; cv=none; b=kvlEU/VxvQC3pKJ8xcMDrJxw7A0szax653xVnbUVSQQh+VUtM5taf1v4pV4inU2fdeO8ropMOTaq9GuJC6kBnEzkMVerzLokIB5ywIwBecuvgUuczEdCq/6jOR7T6bgq6Tq4QelOKSUdfO6BGa2mcDH6CH9UzHheGbC7KCYNxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767162244; c=relaxed/simple;
	bh=pMTxfGXnk/xgum6b3Ju4JTaHnf+7kLXIpCb1ivtuF/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKFDIQfkJTeMXn3A8vDxaKQ332t7bKb/yAdwITh+f5NQ48Ktwo0Mvz5VDch+LIUuXcjPJ1fhgZ7L47Bf5cobYKcwUeKDTDnmZG3L8uTzE3A3NQEhz5kPwwJyTuqffGWR7pON1wT+5kClxwiZiziDSTCXT8QTazabjOrv0toSwO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT7FL5gD; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT7FL5gD"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-786d1658793so93695877b3.1
        for <damon@lists.linux.dev>; Tue, 30 Dec 2025 22:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767162240; x=1767767040; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bwvjUu0d93qZG6sZgfSZozkTZHv3n21XyLmLwrQR6uk=;
        b=KT7FL5gDSWrfiZswiiBUfxMx/p5SxLXFs6fG45uuwpCVPn+9vNvi8eO6AjiYib22zc
         0rmx2lONjxErHDLct+9DbpPSKS0DYm9GapIzVcbczuJ4ohxmEZnGDYx05/jVM7cFJfiS
         4WVTnmbeS0BNTp4Hve76aNq0MWc8HBXYrBtXWBafxAxkV56kD6hUERsmNxuTRfT4lr11
         wsLxjWnlI5r6GdQvRLYYjJtOZTiFa9sdRCK/Yb07160/4E9swipHoiNtuZ+c5BkPwHf1
         g+nUZqmJAujIfrWz+gVz/rcXB0W3I84JnOSuth9IuUdXkdfJ0TxZ1HM7nh4F8MTe4TIJ
         7GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767162240; x=1767767040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwvjUu0d93qZG6sZgfSZozkTZHv3n21XyLmLwrQR6uk=;
        b=jD6ln5LSkult+S1clkVzTOtFTWDB3qWHtt82EIHJYOWRjX3VIQ1oY4QAjhyiGTuEK4
         349jUJFaGQvG8xXGNwG7nuiFDvuljfQZLyMcQoi7H+G5P1WqmIXpZEq+tTxrayyIoy2u
         7gLBGQO3NkLP8idky5X4sOd5q75Ks6gQeOcVJGIEqMXv3o4RLGd6J6rHMKKOSSbAtLhl
         HamqWPdg9iYZ1Cc3fLdpDr5tyqz2f3mhCEh6TCoOqa10pbUlapvSk9dQxZ3NhjakPwxp
         NuakUTRDHMahMF0ejTmQ4N5iE1Kt/WbKaTPPGPzNRIMf9+AX6ZDwCmDXVRrkSRR4RGBF
         90mw==
X-Gm-Message-State: AOJu0YzKfGUNi3pFMJC9gBX0yy5AWxO9uRRYi27Bqipq99SP3ci4v23M
	Y3re+9kpyBNm1WFFJlfG7WSb28+GwyUi2eNIMVGLQYwDDNvAKLwZUH3e8yW0K0RzGrV6f3wrr2N
	vWb5OPSZKkjTCruS3JUgdI0+5i72rfi4=
X-Gm-Gg: AY/fxX7f9nwvpfaQlc/MJtSSODfEO+/qtYHc/TsoGFFe5LLBMyx/Y+fErngZzo0wepA
	6VYeKghQcCmTt2NGQXe/H5LojCYhqHrnuCWsRwulmDxycd5toRiKv9NO2ZLjeEMbWZ1Mg1kio6S
	6zeE4ec9RRk13P/gMYM3bLxmac9N6jLgpx1iO99OCHSff+qxcxWjGt/YJafLwhP++ljQoQFYFKk
	DwnkaCnHrXy6SBJA/Vzq6fXM137m4x6/hRVJ13+cmBAtq6GZy+2f6C490neNmurLUhU5pye
X-Google-Smtp-Source: AGHT+IExqKOYs2I0mOY5AkKqfsU/Mkp8RrJDp+UD/RFlnNenrvmaZMwK2b9yRpYc+pkmxj1Y/3gk/ywpaOz7YD1biNw=
X-Received: by 2002:a05:690c:c4c1:b0:78c:5bb4:1d4c with SMTP id
 00721157ae682-78fb403af1cmr638283427b3.39.1767162240391; Tue, 30 Dec 2025
 22:24:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251230005716.47160-1-sj@kernel.org> <20251231012826.75989-1-sj@kernel.org>
In-Reply-To: <20251231012826.75989-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Wed, 31 Dec 2025 15:23:49 +0900
X-Gm-Features: AQt7F2rI-GvhmFH5Jx0faiK5sgTkGJp3IeIlGfr1oxMY5MYCA1t_-vBC0NNbn5U
Message-ID: <CAHOvCC6RwVzujJcuosiignDEQoe038eRJHuJVLEtJ4-qP8Ot9w@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: modified control->repeat loop at the kdamond_call()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, rgbi3307@nate.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Dec 2025 at 10:28, SeongJae Park <sj@kernel.org> wrote:
>
> On Mon, 29 Dec 2025 16:57:15 -0800 SeongJae Park <sj@kernel.org> wrote:
>
> > On Tue, 30 Dec 2025 09:14:37 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > I will reflect the above in patch v2.
> > > Would you like me to resend patch v2 ?
> >
> > I just found my fix [1] of the bug that you reported has a race condition.  And
> > to fix that, I think kdamond_call() will anyway need to be modified.  I will
> > shortly send more details as a reply to the fix [1].  Can you please hold this
> > refactoring until all discussions about the bug fix is done?  Sorry for your
> > inconvenience.
> >
> > [1] https://lore.kernel.org/20251228183105.289441-1-sj@kernel.org
>
> I ended up sending the new version of the fix [1] without changes on
> kdamond_call().  Unless you have concerns on the fix, please feel free to
> proceed to v2 of this patch.  Thank you for patiently waiting.
>
> [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org

My patch for the kdamond_call() function further improves control->list
to behave as a FIFO.  This also improves stability against the control->list
collision issue encountered when damon_call() is called.
If there are no further objections, I'll send you Patch v2.

Thanks,
JaeJoon

>
>
> Thanks,
> SJ
>
> [...]
