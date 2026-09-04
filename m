Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46830D411
	for <damon@lists.linux.dev>; Fri,  4 Sep 2026 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509598; cv=none; b=htphwTHZ2DrYYpW8PtDAXOvm37w082aTTrJ+Y07bCOXwsaIepq/MHTBheCy7HVZ7EdwRJUDNJivux9QnN5O5/b6ekn7cUz46j1/wwP7PbVHUDPrXkGacPRN13q1iC5LyCoYIA6kBpStl2EFPvZu4Wjy05JPExDHEv56/XIcwEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509598; c=relaxed/simple;
	bh=ttsZXUpX/RbFo0lv4pHgTj09rIccNhb/+DkQ1zy3hw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuCyVmoWheKH/WTLIz7ldVI6gZmt/1r/S6x6XCWWdpYVH86L9DEUm4n65I/W4i0Za2eA3QCrw64CTBIp1DT28OQ4g20ABV58pK4ZiPluvtcHl/GMDDCjMQmMknngzPat2D2LChxfnjBvg+NO0xr+9Ax4Chz02bGVn78gWKGu+Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvAGM41M; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvAGM41M"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84830c774a0so771507b3a.1
        for <damon@lists.linux.dev>; Fri, 04 Sep 2026 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788509594; x=1789114394; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0pDAJ5Zbgk6FV/+bTUIcqCISS5VxMKMSD1bvgwX22t8=;
        b=XvAGM41MPBZlzK7rU78pHyoStZjLlVuNxJShJahroyccYmI1VdjktBeWOOsIfB5uIl
         llYGNwMSvTQeJAjIOS66HLCU0EhXalIySSqEqI6nF0imaQTGvxtitGL81TMB5zjn0ta2
         uKehuVb2JYzJc+/O59BuIOXwt/R/2vw6GByp8rdnbUx5x2bap3M8MbvIzPxsaB3gwajQ
         nsVC8Qo7rrYVCfg8OvNKDPLMK85KqLaHiPaqUh56X6etEQ4gisPvtJfwe4RFNmmgmZdW
         XwAfK0kHQoHc3RH55wxosaugSNsOE3GhlFb2XSFd2nKq8EQvxZdaqPaOz1sAKIl2wKyt
         A2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788509594; x=1789114394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0pDAJ5Zbgk6FV/+bTUIcqCISS5VxMKMSD1bvgwX22t8=;
        b=GiUQYaIqGCFdwAOxePkhnt5k41OcfyvVF1pbEfSFicdsnCUTBEsGXl3HTff6b0CYEY
         MWpDIN6ysjZ9bwnaMCRA01P2KcCY+ufGJIpILTR/9BU/YpVLA+DfG8qdvl6v88hhbsQ0
         BRnL8cvUO1XhwJHv0ulo+OSBJmK7mA4KfI1TJFwz5Kk3d41OO8Z6e2SRWZhrD5CeZphy
         +V5wvk/QKRPAe4pwUdZsNbunAqENL391yIcJs1bs6wwXIBHeJmkeYQI8wM/i3WEo6+0R
         /W4Seno2+Alv0DafQWHFiIoirJaYwgVYBwP1rJb1sv69ykj6+PkNcVPFZh+sGO9+5iAH
         AFXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCD/n5vzOa+e2xoes9hGVb0FgnrFyjfv9QvCiBhmSAo3H1M1vfmXVj6rB0ckZ55toUNAQBsw==@lists.linux.dev
X-Gm-Message-State: AFuF++nV4ZrMF+jCdkujxEOtxqCkIdrs1wub5fWMZyO6jMi6+Kmt2XF1
	jLSowHOgu5WgBiFQA/OM10azJNLCsiNMCTBKAhVRVKolQ74v0azNzoRI
X-Gm-Gg: AYBFou09NNlzvy9fmhl17NDM/w14otBJ7TuCwEPFhQEfu2dPqm18EVQ/48g0jiZHQkD
	gRViT+udIuzM9RhCvCAGKUKXo/ySnyemil4hPKBYkRTvszcIZqJx87AfoViFckmHOytJM22V6WE
	vHoBLxCWwhH41Z5ZxtLpmFQpmSiMtNKwXd39XQ6DGtEgmP/hC7oNuy1A4F1/mNz/dt7muo//Z3d
	oORYtuYfVb7HDuh9ALD66rPgqy+1e7U/jzN6uj3U76GXMFnb5tm6gOvxbhnIvhCiSkRvdikbjfM
	Jv1Cy19yW/NHpitQg2THiy0TUvj5b26RQv3Jj3pcrPuJdmm0zY0Bv6foVKfJ7uwrWT2JXqhHEMz
	xOE4z1VyIGrw6xWcWhag68Y7aOmtlKSVClRjiV2sxdGc7zUeiRjhsuMIxtUfMGBI0TYWwknwnjH
	zbn94Ux82DNfS/TjaUnHO2XbmwyR87ecYFfHlk6Jf5jlFZTauYOirOsStwoVXEBCwbT9MzwME0Q
	fRI2xxcDZCeXrXgk4I=
X-Received: by 2002:a05:6a00:4289:b0:852:38ea:3fd with SMTP id d2e1a72fcca58-861676b276dmr6641062b3a.11.1788509594279;
        Fri, 04 Sep 2026 01:13:14 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:8929:bbae:36df:3680:44d3:b5e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152c2a52asm862512b3a.30.2026.09.04.01.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:13:13 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Fri,  4 Sep 2026 16:07:41 +0800
Message-ID: <20260904081324.3972-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903140521.98604-1-sj@kernel.org>
References: <20260903140521.98604-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 03 Sep 2026 07:05:20 -0700 SJ Park <sj@kernel.org> wrote:

> On Thu,  3 Sep 2026 20:41:48 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Wed, 02 Sep 2026 17:33:50 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > On Thu,  3 Sep 2026 06:31:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> [...]
> > First, I would like to clarify my intention to avoid any
> > misunderstanding.  My actual goal is to fix the semantic of the
> > qt_exceeds statistic, rather than necessarily changing the underlying
> > logic of damos_quota_is_full().
> > 
> > Currently, there is an issue with how qt_exceeds is incremented.  When
> > the quota is set very small, qt_exceeds increases frequently.  This
> > produces a statistical trend that looks almost identical to the
> > continuous increments caused by the Temporal Goal being achieved.
> > 
> > The original intent of introducing qt_exceeds is to let users easily
> > notice if the quota is too small.
> > 
> > Commit Messages [1]:
> > 
> >     mm/damon/schemes: account how many times quota limit has exceeded
> > 
> >     If the time/space quotas of a given DAMON-based operation scheme is too
> >     small, the scheme could show unexpectedly slow progress.  However, there
> >     is no good way to notice the case in runtime.  This commit extends the
> >     DAMOS stat to provide how many times the quota limits exceeded so that
> >     the users can easily notice the case and tune the scheme.
> > 
> > However, under the current behavior, users are forced to manually ignore
> > or filter out the qt_exceeds increments that occur after the Temporal
> > Goal is achieved.  This adds an unnecessary burden to the users and
> > contradicts the core goal of making it "easy" for them to tune the
> > scheme.
> 
> Still I feel the problem is unclear.  Why the users need to manually ignore or
> filter out the increments under what situation?  Knowing specific and detailed
> case would be helpful.  Are you or some people you know doing that and feeling
> it is too much?  If so, what is the real use case?  For what purpose and how
> DAMON is being used?  Why and how the ignorance of qt_exceeds is being done and
> how painful it is?

First, I'd like to clarify that this isn't a problem encountered by a
real user, it's just a scenario I came up with.

1. Users sample qt_exceeds periodically (e.g., every 10 minutes).

2. Within this 10 minute sampling interval, the counter aggregates both
   the real quota exhaustions and the increments caused by esz==0.

3. When users notice a high qt_exceeds value, they eventually realize
   (perhaps by reading the code or documentation) that it includes the
   counts from the esz==0 state.

4. To get the actual quota exhaustion statistics, the user is now forced
   to perform additional testing and implement external filtering to
   separate the esz==0 increments from the real exceeds.

Even if we explicitly state in the documentation that qt_exceeds
includes the esz==0 counts, it still burdens the user.  The user still
has to figure out how to filter out the esz==0 increments externally to
get the signal they actually care about.

Honestly, I struggle to imagine any valid use case where a user would
actually rely on the qt_exceeds increments caused by esz==0 to make
decisions.

If the only purpose of qt_exceeds is to let users "easily notice" if the
quota is too small, forcing them to manually filter out the noise
defeats that purpose.

Best regards,
Rui Yan
