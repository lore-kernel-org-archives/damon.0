Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C45434406
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907090; cv=none; b=PAPTA5OLBrxGrFmKbehuUQpdhLdpKCDixqtJsd0czILGtsN7xmV0Mk2p/U/SiH4xUsd0EfofZJLm2dOHQsgakYkETNF9HtXrqb1Ia2oIvMauU07+bNFW3dGZn0/S26xRvclY3P8rjjeRujoFOIPBg5eUQUATEQnHQmYa4yiXvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907090; c=relaxed/simple;
	bh=MnugXts7y5D535S+D6T/loR1mtSZRGqEmcfdulAt4RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmRQWLO6D5oRD4hTpoEUin0sJwOepNOE+ZFOn2Pmyuzy5nQ6zikkV5Md1mYqdEIyWnot/ASTeh4GOlV3ZNwprlgJEX2IyiXtaLglSVQnliHLowglzMFKnBJuoDzpOD4Ragf+PF70XQ9oeOp7HynHsd0pmg9d0bnNb7ffwrRaxDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaqMMdKw; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaqMMdKw"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc515bef69dso1381226a12.2
        for <damon@lists.linux.dev>; Sun, 20 Sep 2026 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789907076; x=1790511876; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RYqPAHe6dDWQaMD5MN6ftRH3n900tUiGNAP8+qEZJDw=;
        b=OaqMMdKw/TAswnAPXc6FQz6sVesrlrXmdZ9QJCMGOy2UaPC9QYlBBj+y+MCtZnFlUz
         0wyl5RvrZt0sTvR2nA8jRWiDSS7bSHgV44gdgdog6bHz56g8a2n/0eVOzS3Ns1m/OkHY
         HJ43Eg6uM7GcBSJ/ND+ky7OV8Vx1IhSNrqEo2akNQ/v/BW2PSBBcnjfOanls8BfEI9eQ
         Yb3SFSMIoomMLD+7I3h0gtVoWQtgYV/Ij5hKv1D5l+PIgBhFZv6Bh7FSIChxVYVS88jK
         arshcpbt+B9jtdaeP0RwG18Gpwyqib+oQ8+I/R7LJlkKBu5EtgqvIYqE4dTPWx8pSPTX
         p+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789907076; x=1790511876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RYqPAHe6dDWQaMD5MN6ftRH3n900tUiGNAP8+qEZJDw=;
        b=QNlhx/z7iKiIyjc/cAifxhKmdknV+lRIZbpSji4jgBQymquBcF98smLtaB6xul4GRZ
         kO0B0rTV2p4VexGv9evRyVm+mi8nYK7VCY4lcI6yWsfNxps0U0neaS+DxPAHlSMuNfnv
         C6F+tJDRdztM/azBnRaUHmRmKpIApPAuo3G7c/b3McqmAOHW2GZwAM+vdTom2/hbKb1z
         VwQWjQL+cduuczv9/JqD42ZFeWBOSS/TP9dZIFP3KO+H6RLn61MrNqjZEwHw2VFN022s
         3mXJExfVCMXx8MnzgJsoRKUD0qqPspeKA7MlypWk+g/A0ojYGAHs9o3usPBQTu493STG
         hk3A==
X-Gm-Message-State: AFuF++ld+SMtH4yg2OgFxV565CWaDFeYKd5w/KmSW173oZGHKRc6YKA9
	AaVjGqOZzqUuyKhDWxG1GGoQ7Ep7LXY++TMCzIXY8nTRGqEV6oPUcSY=
X-Gm-Gg: AYBFou1nE4dqzp2eN4qKLtqqNiNe8Zfp1sDJUrUpSnX/AMn2Glls2AcmWm8cadctCqy
	nxDdPqos+TMeAqSOofH5UwUEpJPzjqcNjN7cVMrCwWO0SU4z/tljOJUZycRv/FIUKO2bvnSMWki
	cXqimlAf82JBmLL1JTkNI5/uLgb8pTZMNNmqv5ndhlOlBfyJAgoqYB4Q8NNmWkbzYGHeqPSFQcv
	UgOtDNuCwvwky3rxBuA7VUoL3l8H/aVta4ox5K5GfyjqSrFoEfmg29NYRk3Wz3G4cSwju/c2+/B
	v9x/2WEs/u2GbMNPHJD8sGehQqVAY1b3LJLkm1WZ7oS64KVorj+dukp0qz+dhwQGao73rCUzLYW
	xxc69zbVEjx08Y/yG0eudFh/aiMz9SufxTQ2MCHWzketvsA/jo75YOOY6CCHAuhXmjgeootVl2U
	zTSXzQoidy8FHDCQaJ02Vo44IbdQdbTsiU0ahLyx4+BbjqVgTWX/Yr2VRWHZYmPE1F2+Gz5JuNT
	QeMqj6QGqehwJ3aFise+Pjrgew=
X-Received: by 2002:a17:90b:5281:b0:3a0:3673:dbbf with SMTP id 98e67ed59e1d1-3a03673dd7bmr2099459a91.59.1789907075684;
        Sun, 20 Sep 2026 05:24:35 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:e0d6:4b87:c472:c9ae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a03bcecdd2sm1173362a91.1.2026.09.20.05.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:24:35 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH v2 1/3] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Sun, 20 Sep 2026 21:24:30 +0900
Message-ID: <20260920122430.610257-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920103714.47722-1-sj@kernel.org>
References: <20260920023111.2466265-1-donggeunyoo.kernel@gmail.com> <20260920023111.2466265-2-donggeunyoo.kernel@gmail.com> <20260920103714.47722-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the detailed review.

On Sun, 20 Sep 2026 03:37:13 -0700 SJ Park <sj@kernel.org> wrote:
> Let's break commit message lines with 72 columns limit.

Done in v3, here and in 2/3.

> Why 256 MiB, not 429,496 bytes?

They are two different numbers.  429496 is where the multiply starts
to wrap, and every size above it is wrong.  256 MiB is where the
wrapped value lands on exactly zero: 256 MiB * 10000 is 625 * 2^32, so
on 32-bit the product wraps around 625 times and ends at zero.

> So, the way to work around is updating the size quota to smaller value,
> correct?

Correct.  v3 says so.

> But why a sane user would set such huge number?

They would not, which is why v3 no longer argues the 64-bit case in its
own paragraph.  The threshold is now stated once, as part of what it
takes to reach the bug: above ULONG_MAX / 10000, which is 429496 bytes
on 32-bit and 1844674407370955 on 64-bit.

> Because this patch Cc stable@, let's make super clear about the user
> impact [...]

v3:

  Triggering this needs a scheme with a quota goal, the temporal goal
  tuner, and a size quota above ULONG_MAX / 10000 -- 429496 bytes on
  32-bit, 1844674407370955 on 64-bit -- so it is unlikely to be hit on
  a tested setup.  Nothing is corrupted and nothing leaks.  The scheme
  makes no progress for as long as the goal is unachieved, which is
  easy to notice, and writing a smaller size quota restores it.

> > Bound the conversion, so a size quota it cannot represent falls to the
> > ULONG_MAX the function already writes for a scheme with no size quota.
>
> I don't understand the above sentence.  Is the grammar correct?

You are right that it is hard to read.  The sentence was too long and
tried to say two things at once.  v3:

  Bound the multiply.  A size quota too large to convert now takes the
  same ULONG_MAX branch as a scheme with no size quota, so the
  effective quota becomes ULONG_MAX / 10000 instead of a wrapped value.

> > Widening esz_bp instead would reach the consist tuner [...]
>
> I don't quite understand above.  could you please elaborate?

Sorry, that paragraph was not clear.  It was meant to explain why I did
not simply widen the type.

The other way to fix the overflow is to make esz_bp wider than unsigned
long, u64 for example.  But esz_bp is not used only here.  The consist
tuner keeps its own value in the same field, and
damos_goal_tune_esz_bp_consist() passes it to
damon_feed_loop_next_input(), which takes unsigned long and returns
unsigned long.  So widening esz_bp means widening that function too,
and the consist tuner would change for a problem it does not have.
Bounding the multiply is one line, and only the temporal tuner is
touched.

I dropped the paragraph in v3.  It argues against a fix nobody
proposed, so it only makes the changelog harder to read.

Thanks,
Donggeun
