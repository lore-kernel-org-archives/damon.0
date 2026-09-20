Received: from mail-pz2-f16.google.com (mail-pz2-f16.google.com [74.125.228.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0223B52E7
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 02:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871859; cv=none; b=nhEi4lkg9sylIXkOoVLWrfGVxj4hn16tmrzf5C0GGnFaS/kj21gUyypEjSEE3ffocdoGDEaHSHAwzehMjdhqc+Q6tHJJU9yn4ft1UZ6t2oNkNP7Xvo2gKisDzzGh/VAi4qrxy4peUurJNjGOj9PkjLtCv1wZ0d3gpnHKEDA3lu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871859; c=relaxed/simple;
	bh=G6MJJlrNk7Yn2tf9+AziitycZl/J9WfVYQtX5uMidQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDD83jSGo+HEM2UAOt3FTHgG9FREpUmAYoGRrIR10pRc/HXls+/CQRNqsQnys/ckg88qzuxsfGptrDoarLEPRBpG/SzgVP2/T+iw3G+O4UmlNf9MMoEe5ROoWXNXyHBRWUVaKLum4OB080/8uMajcBvOPqAiZXK1+xhPdqDKbA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUxrinlB; arc=none smtp.client-ip=74.125.228.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUxrinlB"
Received: by mail-pz2-f16.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so1174975a12.2
        for <damon@lists.linux.dev>; Sat, 19 Sep 2026 19:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789871858; x=1790476658; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a661l6/McfJBsW6ih7SIBpxNulf6pfTW6jSdeP75Wo8=;
        b=eUxrinlBg6/hQ8auUeNNHstsZyTd/owhvWVRoogKqNJ/QltaXUIj7qPpNfvZ1XeJ9f
         pl2lVNvqr+ttoT2NJZ1/UMT3PmZt8MHurve4PCW5Q97kmDfd4VWLC8HMW9T6d5U/EXJ5
         XC+7qjFSUfaLmdkdpqpZC8pL+5IW6DhPYymT6b0NQVmiKjV6GjxT2fO5kXM6jwFSD/Zu
         +qCfKUOYwu6yISVfo9d8AnUAXlP+6bxRHiUmJ/IVUdJpAmBqUW2bGDw1o/RnemY+mqKi
         w37bJBUAuFXPz8d9Pf35HngcfBrPisKIzQHeMYPR2CJiDTyZDN/TYrVhPj+XNF2g69Pn
         XBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789871858; x=1790476658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a661l6/McfJBsW6ih7SIBpxNulf6pfTW6jSdeP75Wo8=;
        b=jmHsmeiw5HC/dCtaxeFKk7hXQlM2c7f3HakV8rP0gxYFDEl0muY6ohiKVFjDXdPGi6
         VWOVyG8ug8kMe/oq9gb0WAKimERVgb5z+DZoNkMuxZCqG0M1ceqjOPDkM3IyfTzCwN7K
         saF29toYP5l4tHwWfjMrDZQUFJEsT1vSVLpLEQ8SYDIxWcEBgyeTsWCVutvP2X/xGfvl
         E9s6QZ2s8nEdYZsawr1C4HKM/38/HFErcLlBSF3m0AOso2PEeP9R7kVnzVLmW2FI4z/F
         ogF3qKaHlu7R0bCHxt3DllyenJkurqD8bo3j2lbSwv5z5e58h8friXE+4Zu7uiiBLrlY
         lbrg==
X-Forwarded-Encrypted: i=1; AKwUvByS1FtebdCU49zphDcjpYabzMS9tpYcByAR5toFhACRSiuSUA/mvhI5boZYR/zy0/Wu6S9ezg==@lists.linux.dev
X-Gm-Message-State: AFuF++lKUDTnODh1RBlZ7zZIHytVLKc6814W3NN+ipLd8s69Av93uxW+
	a0PGQ4kVMpH5hQZBNWMHw7ZpJgAQrEihTS2o3Fe2/Pu4YDHQhhxR2Qw=
X-Gm-Gg: AYBFou31xgKrOD1aXNnFk9Xj5sa9idzudB9y8MfH/6Snoq2EUZu7HesiCCDNzAKqqv+
	1DHVmxBAMtQXDdtaWA6P3xyufgmV95ck+YiwzhHnp8z3bzd4k1zjfF40ij6qHeiPNs4uyWmkN+p
	bW76iSFsLfnMrmAMCbrgG42YW4CukBvzcW5yA3MHASY66aDyWhc12RrF0xvl2iBwnRu7Po+1RV8
	DYyiZsU9JCcG20Xbi8/VYpOzugQp5J+NzBcTEzutbGtP3rbK9ZY4zug2gx0RcCdt0jt7/oY4Kj/
	y6fWc2e7w2Vbw2wjAKScM1GVfhugkIAg7KMPgly99cgxGxvp4Bb03O1gi9T8XH5ZDiW+77ycP7h
	xxWLZo7BOOVxN3ZrcaFO2cisZffaTLfkf9DvF8aUZuHII3cGPkBjzuWIk4s0371hhGd2JoiBnIq
	G9NH0A7SLcq2SddE0cYst3C31Kxt3k6lrMJrngjOpbHbUHDjAETSJFqcJ1iXl5uIvDykGFT86v+
	l/oCVszfumgVZoc7GEmjcwVGQ==
X-Received: by 2002:a17:90b:5287:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-39e54ce361emr12233813a91.10.1789871857656;
        Sat, 19 Sep 2026 19:37:37 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:36d8:54a:e0bc:3e5e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c37c8e7sm6799764a91.9.2026.09.19.19.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 19:37:35 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Sun, 20 Sep 2026 11:37:28 +0900
Message-ID: <20260920023730.2468388-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919165509.86678-1-sj@kernel.org>
References: <20260919071324.1583280-2-donggeunyoo.kernel@gmail.com> <20260919165509.86678-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

Thank you for the review, and for pointing me at addr_unit -- I did not
know about it.

On Sat, 19 Sep 2026 09:55:08 -0700 SJ Park <sj@kernel.org> wrote:
> For 32-bit machines, we have addr_unit parameter.  I believe use of it could
> effectively solve this kind of issues.  Correct me if I'm wrong.

You are right that it helps, and quite a lot: with a larger unit the same
amount of memory is written to quotas/bytes as a smaller number, so the
boundary is much harder to reach in practice.  It does not move the
boundary itself, though, since the multiply is on the value written
whatever the unit means.  And as you say, only paddr implements addr_unit,
so vaddr and fvaddr get nothing from it.

The 64-bit case turned out to be a little more than theoretical too.
bytes_store() takes whatever kstrtoul() parses, so a quotas/bytes above
1844674407370955 wraps there with no scaling involved.

v2 says both in the changelog, and your suggestion about the user
documents became a third patch.  I also took your form of the guard; it is
a one-line diff and it reads better.

  https://lore.kernel.org/damon/20260920023111.2466265-1-donggeunyoo.kernel@gmail.com/

Thanks,
Donggeun
