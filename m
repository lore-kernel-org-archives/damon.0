Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C0DDC5
	for <damon@lists.linux.dev>; Sat,  6 Dec 2025 04:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764994648; cv=none; b=OA7R0LZS4oCYiFWT/ei45NJPjvGofFoEX/AjK2c3gnjVlA580ru/eMAL6bAukyz4r3VOIlCX60VpjXUGPzn80qTbXsuLPTChrPxdSnTQq5i9yREuvnGGiDzMPczl0yEmGzYJXXb84xWtwa0uI3G9wYV9hcsS9zdLWlAoVNAGpWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764994648; c=relaxed/simple;
	bh=z6I/SPon5vsFBts0fhfNI+MspwRwOTN1YvMCeneKp3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbATKLJGablqTKDExrTAuOWfeM2xVQWGnJ+4gaRlhIUhhPmZ5JEkXvSCgaOH7Q7wHCARsTUgkvXFbAMXo3PX2lD4b94dS/FgkSjzNqmwjUzxXqYubtFTqwKtsQLhyR94UEzkauC30VH11gOIkduT4cefEJLK3HicBP/eNjUZQgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvQ2aSzy; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvQ2aSzy"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6443b62daf6so2498440d50.0
        for <damon@lists.linux.dev>; Fri, 05 Dec 2025 20:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764994646; x=1765599446; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gCGqBpcBaXv11CyxxHq0NCH/Lzi9jNJrRnRrD7ZpxfE=;
        b=mvQ2aSzy27EvsNnJ+EZ0RGFoJ9j++OakORsY1R9EhOUOTG8Tb99Bj8eEcAJmj0x1Vf
         SymMVXEFx60A/FgqAPwUIEkoS/SpARW2R+kFmHRJwRWCHF/WFCv1QzMH3Furle12rkPa
         bhBwKu+XvGwO98MpK+U95FJKsXQRT+tvXFRzrkNTfitvV1ClbuSmHciEwSubN04Z8sa/
         8oQIFPOB8ka9VJZk2x1Im4v6k9xHsocQbrx+2FZqzySiVVN9j23rTqqHlNBfsi2JLUVf
         9pVGKzEWsBHZaw2Y/VS0PeD3YJZ6EAddHoVg4zQ1IIl7+htk6WMd7Umh1FKX8FHFSJ5W
         VUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764994646; x=1765599446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCGqBpcBaXv11CyxxHq0NCH/Lzi9jNJrRnRrD7ZpxfE=;
        b=dWAUvrB5CONLUljiU7wfW7TiEBAxyH0Vz0xBJHFeO4wlI7223Ykid9UxzYLY7TDsAl
         0vkLFV7N/ZNxSfLn1z0NAcwPfssmuCG8wk6k16VCs6GMsxoULMuONDOUwVrLjTL8zDcq
         LGHY0/FI0cW1Ec4vsMDazgramInevuut8tvw8h8N+An9WV/NcxS7ncBqbxAGPuMxjdlP
         4QQQFkKawJjNVG1pM81yBomtE2aX7/Zsk0TwG9HH3bFIPGwIdH1z9grKRyuB90/KjOUB
         W+LlLXQpCM4sNH0PCl4AxwAcjjRr7VvUAh9H4AIZ8A2hlSLpLSFIK2UqG0P9sQ3g9UHF
         PqDQ==
X-Gm-Message-State: AOJu0YwJapGZm7hMW663evp8TjEgiRNVmtKxbIGa9te3Mox3lEOMAlUw
	yGSEnpeCRfrQJooEwdW1MaxUU35NUMtIskeEV7oRLxBm9EvVwuB6OmS/QSYuJ0++4L4G6P0lGzP
	37NNRbJLdxzbvaEazXH1rROcc2cDlxeo=
X-Gm-Gg: ASbGncvhLxNZKWZ47/P/m2nFlpA0irrk/b5Y3VcZAfg4qNcMgYx8PRj5Fs/n+LoVU/h
	ufl/RcA4xpKMLxjvxGadTND0spO69MX4qch4qlU7aPOR9iv3lHZVLk3LUapTBRfGz1kFDq1CCzH
	04KNQzEaTrCv9mJdUytBM5KWqgFRsjuILB9REUZZSxUPWKpjqO9mxwGlupSwd3dkcrf4LingM/o
	xlHatb8rZ1AOb5tU0vBeEs04SzA/0mYejOwp9cUXJwSZVnIvJgh1jsv/qw5/3+66MUFlO47
X-Google-Smtp-Source: AGHT+IG9/xl2G4VhMoTHl18YwbsrHUhUMHPjfhhJlIvvUrtycYH1yJ1ZnRNrFaa/+v46+WADeOT9m+FhNo77BNMtitY=
X-Received: by 2002:a05:690e:124c:b0:63f:a6da:4b3b with SMTP id
 956f58d0204a3-6444e74c6d5mr956904d50.14.1764994646353; Fri, 05 Dec 2025
 20:17:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251206011716.7185-1-rgbi3307@gmail.com> <20251206015010.47826-1-sj@kernel.org>
In-Reply-To: <20251206015010.47826-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Sat, 6 Dec 2025 13:17:15 +0900
X-Gm-Features: AQt7F2qsagOSR-iF20VCYZdpEZUQbABvnzlLKK-suACb2kbHTO0bBCSTeAWiK2w
Message-ID: <CAHOvCC78_ci_6dg=ctt5HjgZDn4bVmNZw-qfATvShnn_7qoMaA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/damon/stat: deduplicate intervals_goal setup in damon_stat_build_ctx()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, lienze@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Dec 2025 at 10:50, SeongJae Park <sj@kernel.org> wrote:
>
> On Sat,  6 Dec 2025 10:17:13 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > The damon_stat_build_ctx() function sets the values of intervals_goal
> > structure members.  These values are applied to damon_ctx in
> > damon_set_attrs().  However, It is resetting the values that were already
> > applied previously to the same values.  I suggest removing this code as it
> > constitutes duplicate execution.
> >
> > Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> > Reviewed-by: Enze Li <lienze@kylinos.cn>
>
> I show Enze did suggest changes [1] to v2 of this patch.  But I don't show Enze
> gave Reviewed-by: tag to the patch.  Am I missing something?

I added "Reviewed-by: Enze".
It is just minor commit message format suggestion.
Am I putting too much emphasis on this?
Should I delete "Reviewed-by: Enze"?

>
> [1] https://lore.kernel.org/875xal44lf.fsf@
>
> > Reviewed-by: SeongJae Park <sj@kernel.org>
>
>
> Thanks,
> SJ
>
> [...]
