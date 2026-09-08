Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D430567D
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894521; cv=none; b=NNroIAaNI9QRjgFtxKVTXIY62xB47UcEmAlO5EkVCk+o7zbMsW7ukx3/iVUmTM77EoOQQRgzGRORLLf0eXCyi6MRhpQEvTRFDA7cPcmiieBziwi7oeTHCT4knYqN+vzJhgNr8YWOiP836lkUOTr5xMX2d37gJv+4H39kP4vjy/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894521; c=relaxed/simple;
	bh=dPTFHe/0BTatj0iI07P/AMrh0W0nP48S3r20DDxIcDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6KBOPF3olXOH9dDf3Xl19MY8R160vxWjWhnr+zM2Jvh7OJEyyrPOx+m3IGIFxqIO4P3v17huGE+6/QoK6PjgXFiPQIuCk4xzMeYSDCj31reBMcY3AJVddm9IoXkMGSpAJrQ4ScbTzsUm/Fnnd4WE9wD4sRoja68b6O/MbpVvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhERn6SS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhERn6SS"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d91ded8174so39871615ad.1
        for <damon@lists.linux.dev>; Tue, 08 Sep 2026 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788894519; x=1789499319; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U1RoL809GoYxbvdVPYLt0/sti3cyzkVabYPMIWYXI5U=;
        b=mhERn6SScypZQAMwQ8zw/Yy41KsKxWv/F3XyNbQwZ85RhGBhU0lWNJhINqlLxlNEvW
         r7lSy/m5Dh4MZ0Sy9icvxwT6peax8zXLc+ILKG/nlSq1i8Yhq+t3qJNDCLUXEYxO/ICl
         T79nkMW/lel3j4w4Fg9J2A9JjGwJcyJKbJrscREK+JNdB6jE9C2kz819gIua/sT42Pi9
         FfVl41plqzlaHoQigW8BeJ1dAl4aKgM7SUjr5aVfGKGibUxSRyZdj/rR/kKtsJTuomd7
         uItq7aXARzlKTRz8j6al9TnUREutVwvqUuAzCUXiCQueMFPa+CGSXwyF5BARMZFWBDva
         s2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788894519; x=1789499319;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1RoL809GoYxbvdVPYLt0/sti3cyzkVabYPMIWYXI5U=;
        b=fMMKrD8HnYXSQ9uQD4EAWs1WQqyx+sqGzfNjRB0SNEZP0ENGLa6jOAj7M/+pibMomW
         rfPP13Qo9/AOIDyZqr/fld/xihNBoXMtWgPuhvJqbOllM3TzuaXdPS5HPOVdnjKRph7O
         lqU5snc6xhQ2QylLLQBN6Vc9+dsu+HP1YKMmsllTrP/10P65AeaN9d/DDV5QuNwLb1Hr
         moXWWzVPYlsaDc65KdGVc4QxUuMKm5vDVSXw7+ugHaPnlwFJ2Vu1KYvxMY3Ipl4cuROl
         ibp48twqcg7xUY13+IMEVD+EPKbBemfkrz/GxUdviuzZHq5YBg13asN1ToMI1jG/qlgC
         TWcQ==
X-Forwarded-Encrypted: i=1; AKwUvBwY/X4ryrr9rk4qhkKT3Q056Qe8PRmMekNak5CyLfSp1ocNpM1CS0nMSAXb2cmeEY9Rwe+9yA==@lists.linux.dev
X-Gm-Message-State: AFuF++mQ6NFwse28Z4UmvcfylcM9eUA/iGcWIpn0c1aCF+Xwx2w9WXWP
	IIXMo4mYUC6xE3Hce/zYy8Od7kIvC9OrEiKBYZ6WFl4ITkQvGCkQvSa9
X-Gm-Gg: AYBFou1rj2TIXQIYH6m+Tot0lJzaDQR9tH8WyjVvvXtpIdn2oP+fA7MkGR1Zie7I33i
	2VDpvjfNtWt5F//Ft+wagUa0Y7lg0zRRuQPt7OWpjlNFXlJc7lSbt68iQ2rCdZNcF1CZhfrXFfU
	kTdOVHWG/mG1c5cCcC4SAvgTfpyVbYj3JDeqF6oXOxrgq1keEqq6hfYCX/qvyKwtBYuXrvLSD52
	vUkBD/BS2SAtw8b0cWGo3yOu0+FtaSYKnZc/9c8WQAbfEEm4B3BhnPjATDb7NaQsDGor8m+S3G3
	1h/qDb1d3p/fWz9dE+h4BCIG0FThOJWMvcy3IwIkMOzwIu2kWB1AKRANs9cNVmSb+tJM5tgcIil
	y6RmTp80d+V2Trtb7UxLDnvWXMffwJAuS36OaAlnzzCu3lvhpSi5xf9mlvgWxtiJXGJBaXD2E/y
	u2um5G+GFgu9xmSt9nVGRcTTZyz7FopB4DjILjDnHX/rF4tKyzGwsyB1UZopcI820XJWyh735gB
	yGMm2DrQX/pVlSWZg==
X-Received: by 2002:a17:902:ce89:b0:2da:e967:7953 with SMTP id d9443c01a7336-2db125f1626mr400773425ad.12.1788894519218;
        Tue, 08 Sep 2026 12:08:39 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:885b:4183:b098:c1b9:7033:be8a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495b4b2sm62739355ad.15.2026.09.08.12.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:08:38 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sashiko-bot@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	sashiko-reviews@lists.linux.dev
Subject: Re: [RFC PATCH] Docs/mm/damon/design: clarify when qt_exceeds increases
Date: Wed,  9 Sep 2026 03:08:49 +0800
Message-ID: <20260908190851.341858-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908175548.2D95F1F00ACA@smtp.kernel.org>
References: <20260908175548.2D95F1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 17:55:47 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Grammar and punctuation errors in the newly added documentation paragraph.
> --
> 
> commit 25ab17e2d03e88ea28912107d200a293e1a57614
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> Docs/mm/damon/design: clarify when qt_exceeds increases
> 
> This commit updates the DAMON design documentation to clarify how
> qt_exceeds behaves when quotas are unset versus when they have a zero
> effective size quota due to the temporal auto-tuning algorithm.
> 
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > index d036340dae8af..e083b74d618b5 100644
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -863,6 +863,16 @@ scheme's execution.
> >    completely tried to be applied.
> >  - ``max_nr_snapshots``: Upper limit of ``nr_snapshots``.
> >  
> > +``qt_exceeds`` is increased for schemes with set quotas when the quota is found
> > +full at a quota reset interval boundary.  While the quotas are unset,
> > +``qt_exceeds`` never increased.  However, a zero effective size quota does not
> > +always mean the quotas are unset, if the ``temporal`` :ref:`auto-tuning
> 
> [Severity: Low]
> This isn't a bug, but would it be clearer to use the present tense 
> ("never increases" or "is never increased") instead of "never increased" 
> to match the surrounding text?

Thank you for pointing this out!

Yes, "never increases" may be clearer.

> 
> Additionally, would it be better to separate the comma splice before 
> "if the ``temporal``" into two sentences?

If this is okay, I will change to:

    [...] quotas are unset.  Specifically, when the ``temporal`` [...]

> 
> > +algorithm <damon_design_damos_quotas_auto_tuning>` is used, the effective size
> > +quota is set to zero once the goal is [over-]achieved.  Since a set quota of
> > +zero effective size is always considered full, ``qt_exceeds`` keeps being
> > +increased once per quota reset interval in that case, until the goal is
> > +under-achieved again.
> > +
> >  "A scheme is tried to be applied to a region" means DAMOS core logic determined
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260908175105.42558-2-aethernet65535@gmail.com?part=1
> 

Best regards,
Rui Yan
