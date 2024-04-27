Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1793A1D3
	for <damon@lists.linux.dev>; Sat, 27 Apr 2024 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714252725; cv=none; b=n1qMybWxC87o7LiPSMNxtDSm6l5BDPIANoDoUnexxFNpEsJ06meQpQfVWGyWcQ2tYBNRiubmEc1fvOjxEgCd0yRbs8V3vWwifmJMsfu43k6CQfA2NnSuAC6EXsXm+EISBchXZGtgTtLH56BVyrizQTjjZ6xq+vXBKtuUZXaMGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714252725; c=relaxed/simple;
	bh=PZkxCYjpRSskE3adKCC/dSB0Ivo1igvSmzkjrqqYFjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYQgK6sFexURLwBfbIFZrpn+wYBN1mjAgWbjN8XdlH/CU8oTaSedsJKPx8KqnbxH+qkW2Vyp+ItRwTmtHO79lkC3lymJgE+VzMVrGw2uGS0sFuLEse8ZSj3hXLhNFdiC8DMZUzNZ/2rzCAU1dTtrWlXForHoo/YcgVOddwcPCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaMCtwWs; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaMCtwWs"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-790c36dcee9so66807985a.2
        for <damon@lists.linux.dev>; Sat, 27 Apr 2024 14:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714252723; x=1714857523; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7HwBzLdUfmNx2DoKYy1/a8lmkPXgeOEF4KRwlhT4mc=;
        b=NaMCtwWsiKO5FPEECpf813c6ZKZv589j6mhcbvDckeXZIxKi7lnWI3PxP5Zw3HpFIS
         55BNunkKPMUPOaZjZGKEstyaBf0Eay7ipw7emuz219YmrusQ3v7JOG7diUKWJMPE2w22
         pwWnd4ls13INHFp7FK666aNldnzMplTah99aTxmGTk2K5QIOQ7wQ8QweJJisNOgUM9+U
         LYtaCix+B16sTwiLf/AIXxYbMRLhj3wKRZnDrzFXuj3j7XdyoX75QnxTZL8uhbtr7ZZV
         vbfikSs4blfQ6WNOtNcmQrCZxFMWFUc+uWJ3zFHooihzXcumqL73rsm80QAq40iB7UKN
         aR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714252723; x=1714857523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7HwBzLdUfmNx2DoKYy1/a8lmkPXgeOEF4KRwlhT4mc=;
        b=vemL/mRwvjKR6kuD1Jbn4PJvNnK5U1rysAzIInofShMvGtteskfRfxN51T4gasTn+X
         PSnOf4885KpZPAMIM5tjgzClqlbh64nVCJEC41ATDbaUUqn6THEL66Ucsuw9uN3W5Pe0
         UtHMIBfWIq7s1CO5nn80R84ZE9kydfI95HuQJulRay8feQ2O0EbiOi0hvD/MCSYNR+g8
         svvgzAM3gCHyKaHNnBs9uiVGTNGfSRznORu4cLSRi1z1YosisT7nqnosMHWNg/iNwG2c
         18ZSmspyNCL/SAnQEPrKvxPkDR9R5AFB0/tfyC58jR6zx8G4HkcsKUAUnva/TdzlkDXB
         A7aw==
X-Gm-Message-State: AOJu0YyeXzE1KXVD8hTtWIaQOxu9PFDvEsDnhnZeGXfZkgS8If1PfA44
	v7U7oM/NCHTLup79zfQ8bwl71Yt6GaZ+IC+p5H0i8HPriRFGrSieRAgjcvColbCtq16hZ173ov+
	c4uUX0cmfe2yusOq3495++0O/B4Q=
X-Google-Smtp-Source: AGHT+IEFQcHxZbPmmQZiZWYxulCeqXN3h3N048XAvqB8jef8qrsD+G/ivfT95keh+4wULYp601O2Zw7mDjaVS6b1FXk=
X-Received: by 2002:ad4:5de4:0:b0:6a0:ae4f:cd4 with SMTP id
 jn4-20020ad45de4000000b006a0ae4f0cd4mr6248935qvb.40.1714252722491; Sat, 27
 Apr 2024 14:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKJOkCr86bMoOgxnJQu8Ry-W-2XHYn_xgyZWL4pTPCgcGK3_rg@mail.gmail.com>
 <20240426200408.100431-1-sj@kernel.org>
In-Reply-To: <20240426200408.100431-1-sj@kernel.org>
From: lokesh jaliminche <lokesh.jaliminche@gmail.com>
Date: Sat, 27 Apr 2024 14:18:32 -0700
Message-ID: <CAKJOkCpsGfRk-KiWg365=shgs5_Rki07=dhF4_b-Zr2Wznz08Q@mail.gmail.com>
Subject: Re: Regarding DAMON sysfs usage to get memory access stats
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sounds good! Thank you for the pointers; I will check them out.

Thanks & Regards,
Lokesh

On Fri, Apr 26, 2024 at 1:04=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hi Lokesh,
>
>
> Sorry for late reply.  Somehow I missed this mail.
>
> On Mon, 22 Apr 2024 17:51:21 -0700 lokesh jaliminche <lokesh.jaliminche@g=
mail.com> wrote:
>
> > Hi Everyone,
> >
> > I am currently experimenting with DAMON to gather memory access
> > statistics for virtual address ranges associated with specific
> > processes. I have followed the detailed instructions provided in the
> > usage documentation, but it's unclear where to find the resulting
> > memory access statistics.
> >  Any pointers on where to get these statistics?
> >
> > Steps
> > # cd /sys/kernel/mm/damon/admin/
> > # echo 1 > kdamonds/nr_kdamonds && echo 1 > kdamonds/0/contexts/nr_cont=
exts
> > # echo vaddr > kdamonds/0/contexts/0/operations
> > # echo 1 > kdamonds/0/contexts/0/targets/nr_targets
> > # echo $(pidof masim) > kdamonds/0/contexts/0/targets/0/pid_target
> > # echo on > kdamonds/0/state
>
> After the above steps, you can get the monitoring results from 'tried_reg=
ions'
> directory[1] of the sysfs interface, or by collecting damon:damon_aggrega=
tred
> tracepoint[2].
>
> However, I'd recommend using the user-space tool, 'damo'[3], if you could=
.  It
> provides more human-friendly interface and visualization of the monitorin=
g
> results.  For example, the above step could be reduced to single command =
like
> below:
>
>     $ sudo damo start $(pidof masim)
>
> Then you could show the monitoring results snapshot in realtime like belo=
w:
>
>     $ sudo damo show
>     0   addr [4.000 GiB   , 16.245 GiB ) (12.245 GiB ) access 0 %   age 7=
 m 32.100 s
>     1   addr [16.245 GiB  , 28.529 GiB ) (12.284 GiB ) access 0 %   age 1=
2 m 40.500 s
>     2   addr [28.529 GiB  , 40.800 GiB ) (12.271 GiB ) access 0 %   age 1=
5 m 10.100 s
>     3   addr [40.800 GiB  , 52.866 GiB ) (12.066 GiB ) access 0 %   age 1=
5 m 58.600 s
>     4   addr [52.866 GiB  , 65.121 GiB ) (12.255 GiB ) access 0 %   age 1=
6 m 15.900 s
>     5   addr [65.121 GiB  , 77.312 GiB ) (12.191 GiB ) access 0 %   age 1=
6 m 22.400 s
>     6   addr [77.312 GiB  , 89.537 GiB ) (12.225 GiB ) access 0 %   age 1=
6 m 24.200 s
>     7   addr [89.537 GiB  , 101.824 GiB) (12.287 GiB ) access 0 %   age 1=
6 m 25 s
>     8   addr [101.824 GiB , 126.938 GiB) (25.114 GiB ) access 0 %   age 1=
6 m 25.300 s
>     total size: 122.938 GiB
>
> The above is only a small part of the features of the tool.  You can get =
more
> details of the tool from its usage document[4].
>
> [1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#sysfs-schemes=
-tried-regions
> [2] https://docs.kernel.org/admin-guide/mm/damon/usage.html#tracepoints-f=
or-monitoring-results
> [3] https://github.com/awslabs/damo
> [4] https://github.com/awslabs/damo/blob/next/USAGE.md
>
>
> Thanks,
> SJ
>
> >
> > Thanks & Regards,
> > Lokesh
