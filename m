Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B664519AD70
	for <damon@lists.linux.dev>; Tue, 31 Dec 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735649817; cv=none; b=elUU1wmyF3phZmye37Q+TOncs8KdToYNU5go/MNcWdcazK9Vd/+oLJHZJBqo+AjrnSx+GyZGd6g0S/1CMMF3/57UA9zhOZFhw26lI/i7mJCs3g+fuxBuubFhcdB4XhQvuwtyAOIaXRs6zRMec+cwXkR6h9MwYmio0lh0jFD8BCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735649817; c=relaxed/simple;
	bh=PTrFPSutZRAdy5raZoFjvJWjRn9LDZqXEb160Tp66SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgfwDoDx6HrcsSBk4RKZ3U4IUnFjbb+zYHW6EFOgXaMqXJA5KiHzsnIi1a5AYb3xLiBfyXtIecI5EyoTKWyjzsxdgMVRA0KRyrYYRaRMAaoUQhf0EnJnTwVcP4AknxsrVO/J6fn4KvMk28Ew7mh6AfSzZmSR/b7aUYv7nj3a/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOkZWIUI; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOkZWIUI"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d8f75b31bfso86093666d6.3
        for <damon@lists.linux.dev>; Tue, 31 Dec 2024 04:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735649814; x=1736254614; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im/fCeDMzw2weP90rU1Vy4eELh4ELx4p/j77zhGeBik=;
        b=YOkZWIUI8wJKQO6CxcpxaP2aZm84lZilLcYmC81fL950ixb1EGWI/HJCJGwc4YUlkG
         lsRZ+UZ1ZlVJlrW0nQUeTCzhRMXJCN8w7D7iPARNKbA/Co9CeD8h8v+cV0lbpxkeKCBG
         dADvchZhWAchxSX4n2g7rN9y1r+lJmYE9AM5jp6PJlY9dmwn4MQwBN3q1QGl7VARjps+
         Y7GtSTJXA2MXAFmJXFGrM3U/oVLGYcymgKAbbXhz0FbaK4lvQKe+sNECIUf/Zjb9GCV3
         rwJHO7X1t6ZFvcPOS8Zu2rIQqYe9L8zi3AMoYJeB2ix3oQE6v+GP8K65CKCdL3XOdiHW
         LWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735649814; x=1736254614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=im/fCeDMzw2weP90rU1Vy4eELh4ELx4p/j77zhGeBik=;
        b=n5/QGgWR12NJ1TtorwXUyGKtGCWfpKi6b27PrEi9qrPzqcx78VLF384WLY88WKbaCY
         ozIfuO6rvBpDsQoBhD/zRBLywBynsb+Tc/Dyl0zkl0hJHl5jNmI+vHZVVqKy9L+cmgxL
         rUldcD3vrieek0luLCaFNzxFDv5ZKg2RhOTyRg9HfljX4twxydZpa7Dzxr23k1zRCzqv
         ASaFcEXIzbXXhuHGtqLmHH9JY3K4kmgV1eoebKm0xKDuCsTZEwtF6CClIVNSCH1ag/kh
         T5efte9X4qJb3YLoThP+q1D2SNtVrtVPmL5ENDpLZcQwLsOrrZGV0SSWvpTSuCd7f/N1
         uH2A==
X-Gm-Message-State: AOJu0YzMN2RxvvqzPtEdE+HxY3lS8X4kJvoUcq0knPbhCtUmLGRgPYen
	I2Z/RNCLBwqw9nPfYnN0k38nwN1wCD0WwkhNTR4vfNC2sdRKqXr6JzrkfqfLXyue7/IqGRxnJ94
	xNG6bl1ZgukrZcKQyRqSBDQcUoxroYmYy
X-Gm-Gg: ASbGnctJ9TX3kD2kzxj02dNmGmWAFYH4v8AA96mQp+dK4TPDL0yNZzu7uJ/KNB0csjY
	al3sYy3+/ZqNwaUBN36ca3j5V8Fmb2NYNz/eco2FlYS/G5shsb+uph1vrxbxuCY6nfg==
X-Google-Smtp-Source: AGHT+IGizSNEKeEWqISo1EHAeH3OK1CXQHPoI+x42ejZOu0VD8lc5CibaCReHBm62aI72ktSMgJojBtjt0U53RX9M3Q=
X-Received: by 2002:a05:6214:d0d:b0:6d8:9124:878d with SMTP id
 6a1803df08f44-6dd2330c4dcmr628284186d6.2.1735649814242; Tue, 31 Dec 2024
 04:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241230182813.14349-1-sj@kernel.org> <20241230183909.14559-1-sj@kernel.org>
In-Reply-To: <20241230183909.14559-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 31 Dec 2024 21:56:43 +0900
Message-ID: <CAC5umyh9k_xvRws9HdmuF8op424VL8j50304+m=GsY+jfxADbQ@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: trace: print address range in hex
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B412=E6=9C=8831=E6=97=A5(=E7=81=AB) 3:39 SeongJae Park <sj@kerne=
l.org>:
>
> On Mon, 30 Dec 2024 10:28:13 -0800 SeongJae Park <sj@kernel.org> wrote:
>
> > Hello Akinobu,
> >
> > On Mon, 30 Dec 2024 22:42:20 +0900 Akinobu Mita <akinobu.mita@gmail.com=
> wrote:
> >
> > > Currently, the address ranges are displayed in decimal format in
> > > tracepoints for DAMON, but hexadecimal format is easier to compare wi=
th
> > > address ranges in /proc/<pid>/numa_maps.
> >
> > I agree that it could be easier for the use case.  But, I think writing=
 and
> > using a script converting formats for DAMON tracepoint output or numa_m=
aps
> > could also be a way to resolve the issue.
>
> For example, we can extend 'damo' to optionally do the conversion.  Depen=
ding
> on your use case (if you also use 'damo' for your use case), it might be =
a way
> to move forward?

I'm currently using perf trace (-e damon:* --libtraceevent_print) to see wh=
ich
address range accesses were detected or not, so as you suggested, I'll crea=
te a
script to convert the output of the perf trace.
