Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1258532B997
	for <damon@lists.linux.dev>; Wed, 14 Jan 2026 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768421945; cv=none; b=TROqB3+B+ZZlsd3Yy4ukVGyfwZvPbaCB4G8ZF8n0GXVW6Z2Ja00atsdV1uKQDwp3IYlg9uXcabPLikKtJYmQ0LLzSqi8siZhp+9Pxg365GHnEPtdwTKI51KBob7oBw6KN44Bm8LMm+r1YOK6iOX6GENwZZU0mKt+3lEtJt/HVws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768421945; c=relaxed/simple;
	bh=d4ulVxVutuMHlp9Hl5Extnr7XoGq477Fvvmoz5+wkcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+8/dvNQWzeHaB3XOieAsmXsczah7epag+DHLVTupT3GTc0itUVSxzjcWdnDsQsVBdW1Cj34dDIMBNJaoVtGQl/lIRtqXTh2SrjrjO2wwJD8GYIVNTFpKlIvh6RQIg7ukRjEs2TFodCvwfq4Jx6JpVpUL+q/U34tXOEz+GSIDXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fItoANiu; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fItoANiu"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78c6a53187dso1640207b3.2
        for <damon@lists.linux.dev>; Wed, 14 Jan 2026 12:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768421943; x=1769026743; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NnVPunCdziCYjBPDoSF1dzwrlBIY0pMxQWPBf1MeQGI=;
        b=fItoANiuOrp8R4TsgnMX6VE3kObJzz2eTxOoU25gA07296NRYAeOiq+NfuamSuJwfJ
         7xIUzmP0yFUpRwLnFVM/dEFbph6L2nPvpJ0GeIVnEGDh0xpTw+ouKlJ4D1SHTlKKqvV7
         IGLsjCYdN0KPgKLlIjLoOHksCPLay7P+6/9cclXYsu1GrMWlLmEkY0bb0/qgwa9ynmQj
         YynG7DNqDU/hIV/AT4KMoQSoDCfORydq7B6ea9Vhsf4/uLff0TxFw/BMh4TJgaL4abLi
         1Nv71rGiv7L4Wie+BuRE1iAVK42xU1W2G3w0FINh5RqhsKnRlpV38ZvFlRIrC50Dnph2
         SiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768421943; x=1769026743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnVPunCdziCYjBPDoSF1dzwrlBIY0pMxQWPBf1MeQGI=;
        b=C/uNPmcy6pV7rvnws22NiCFDg/4MK6HVH24lH30m4AdEv7JlXNh/i1/rYheepk6J0b
         WM67NqyKDJGq3vD8s/MI0quTtHh+inBDyLLTU+aexq85P/7UyznTIaHWd9QXoA9m4Wo7
         CcM0IOowLaCJ3QJmvDrlVLTv0b8BCnIycRHkklOlQAL1sPhWIOpB/vsOPNoXmgSIfKfk
         hmtL6otYOfLUrXAMBWposKKjhtij6YgyeS+opSdg+fW3e9UvVfdYI3o5IaCCbA8TWo8h
         +FW7iMjhzt+fAYxrAmv8nRnYr1vebOZ0wjQnpEC0kpX44CCfbY6xsLHClvh0SYcjfwnA
         004Q==
X-Gm-Message-State: AOJu0YxqN+MpFj2LpH+1EK42aJzJB0jw3T3Cy1tcmMqITMZjrLtN1spl
	639k6gj1bm1RbxDDjklII3LjtFOYSumqlidhRF+izyeuUuTKzlI+/esTYHEO7fd99ARS+aD9IPR
	QEG0fwhV87p1K3VQGeFi1vshN/xJqk8k=
X-Gm-Gg: AY/fxX5s1RRwdjkoGPeGLz4t6gKB7sEbnSEytf1rt62MQygjiHoPblg3zvBPgwzJj29
	PeSgkniuBW3cUySJY5KRY8YCrZrEHhLzTP3a42nb5j5yPZIk/trCXhGGTpZYn/jIeHPLtAhDtik
	J/1aeOQfzDVr83buDf+pliHFDf2mOZ4MjPQfu5YFhx5ioSasdvJK+6ubZ4BW++JLwqbl24LSGzT
	hTodAm4JU1L/PHkK1DS0oeu58s4TfYrnD9qzSjkUgO1cEkFJ//fU62dx048cjJn1hzZKIkY
X-Received: by 2002:a05:690e:d47:b0:642:11db:f5f9 with SMTP id
 956f58d0204a3-64901b0bb71mr4320721d50.55.1768421942984; Wed, 14 Jan 2026
 12:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260113121646.31441-1-rgbi3307@gmail.com> <20260114154622.100466-1-sj@kernel.org>
In-Reply-To: <20260114154622.100466-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Thu, 15 Jan 2026 05:18:51 +0900
X-Gm-Features: AZwV_QgIjApPfUqHCJ9CXsY1zOWH5eS4Wjd7hCBP9UHgwERtGc2_9jqPezDh2rg
Message-ID: <CAHOvCC4kktZ5rvPmJKpeHkOznbmLAxB1GfowU7NgLc1EUA3-hQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/damon/core: modified and tunning damon_split_regions_of()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rgbi3307@nate.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 00:46, SeongJae Park <sj@kernel.org> wrote:
>
> Hello JaeJoon, thank you for continued interest in DAMON.
>
> On Tue, 13 Jan 2026 21:16:42 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > Before modification:
> >                                                              sz_region
> >     |--------|--------|--------||--------|--------|--------|--------|
> > nr_subs:     1        2        3        4        5                  9
> > split random:    <----------- (*] randmon        LOST -------------->
> >
> > When dividing sz_region at rand, the random value may be small, such as
> > 1 or 2.  At this time, there is a problem that only the front areas
> > corresponding to 1 and 2 are divided, and the remaining back area
> > becomes too wide.  If the area is too wide, there will be many missed
> > address access judgments.
> >
> > After modification:
> >                                                              sz_region
> >     |--------|--------|--------|--------|--------|--------|--------||
> > nr_subs:     1        2        3        4        5                  9
> > split from   <------------ (sz_region / nr_subs) ------------------>
> >
> > It is recommended to divide sz_region evenly in the ratio (sz_region /
> > nr_subs) rather than using rand.  In this way, if you decide nr_subs well,
> > you can logically match the number of divisions and their sizes.
>
> I was thinking about how to reply to this patch.  Since it is taking unusually
> long time, let me add short comments for direct future of this patch.

After much thought, you ask a simple question below.

>
> The existing code uses random() for a reason.  This change might break it.  Can
> you further explain what was the point of the use of random(), and why this
> change is not breaking it?

To find a needle in a haystack, is it right to keep poking around randomly?

>
> >
> > Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
>
> Unless you can give me a convincing answer to my above question,
>
> Nacked-by: SeongJae Park <sj@kernel.org>
>
> Same for your followup patch [1].  Btw, please send patches of same series as
> one thread from next time.

I sent you two after much deliberation so that you can see them clearly.

Thanks,
JaeJoon

>
> [1] https://lore.kernel.org/20260113121731.31468-1-rgbi3307@gmail.com
>
>
> Thanks,
> SJ
>
> [...]
