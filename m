Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DEC36EAAE
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245944; cv=none; b=YfcYwZpoQN5sOh8tDB+HN6TUHrHW9Fiu/spbzZXKveL5hmxwOEKNVxVp0pQJAay5ZdPgThF/fRJVTAp/H/qm3Lf7q1/LSiu0ns2y9CkYEwAlEAa+1v/uutQP9UHIAtDt6LsTtQWpohXxRa2W+kNg6yKiNgPlUNHwU2QYeY5QcTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245944; c=relaxed/simple;
	bh=p1ecGBLAUPlq0PWhqjYuX07pIOBgZZpehoElKPBJu40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diUO30VsFK5RM7U8YQlLeLONH1l/jmUuHQW43aVoW4FSFp6L9vaiJYo0e+g4FaERsoJPTfpFxnmBum+G7fOuq/2Gxvd0pc9eHi8KfFreOrNxSnbVHPR8BIyNapHu4s46L6Eo5NP3Vbuw9g94w6nbpIkDrE1WFIwfZg+oMibB0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6p0v9Gr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6p0v9Gr"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-85339ed040aso3809939b3a.1
        for <damon@lists.linux.dev>; Mon, 31 Aug 2026 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788245942; x=1788850742; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=agpKfLahOgIlbtuVqPJI+pV+aaacYEptBf9ONahRpL4=;
        b=X6p0v9GrPqWwFil/nksGTgc3YFcbnnIzO9DL9Es/pEKjI0rWTqPOVHnUvo0K/5KyNM
         5asKF5UIEIv1lIDeRAP2PEw6cflvNc5mhs+/7zzuWpoFrOuj3q7662PeoVr/az3ujAP6
         SCFyB2UZAMe23TX/EUHR5YHr8MpERdF6xEYrroeZQRDbit3RUcrPVo96j4cHsvn/TE+t
         iZXwb4k4Kjv2TRSKF7ymhHU/dfLCrFY5ykMdmXVZNp7y34199UiFVJfHRKIl8r2ln9ap
         KibQXpsPMGwYB3ckb1qxNZXcjgnGPdLykeEMoPdmB6I2B/CeLRmCAZxCkrcx/yoXSZ3R
         lfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788245942; x=1788850742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=agpKfLahOgIlbtuVqPJI+pV+aaacYEptBf9ONahRpL4=;
        b=Q5jftIwCqsVgGqF3tvht3TmFrj9tFFabZUKMeeNpNkGdDeJYs35Ta2EUP9N8XQDbap
         gdRP6vt7sDdVdg74GV/CKX4u3FyLvD9on/7mdhfaUZYDb++5pzG7HsJ3p2wNYjeshXnQ
         A9wmUZ+7uFen1ylrPdgXMP5P1jmA3+NoKNdofaVOKYRsb5Dnv1/h5sXuSp/Tn8vVGcU+
         MN+eFOEmqo4MBkkF68JyufCE2I0zAQOTxVakAZPSbA4H4YSrS4OGCbnW7U2Hmm6Uao7L
         3x4epe9f2Hcq8ipkKLw9nWhsb9hpb3VGKjh+Cej9HpKUXHg6i4OUzLZz+avrMAiM9vKh
         JBsg==
X-Forwarded-Encrypted: i=1; AHgh+RrzUXhTXjZagbXAj/3afxQs51Kf6V8VMedjMyCIzPL8XOE44hNxFrsk565eY4xY250kncyWuA==@lists.linux.dev
X-Gm-Message-State: AFuF++lwoidGBdgEQjJ/9fgppeqcd5CfVKvv5vzgtU00DUiOyHkOZ/gX
	wwM+m3dEpaJxkjoYtuzUSqsCd8od76b16rfZA/Vtj5UufXYZv1QxqTzi
X-Gm-Gg: AR+sD10wGhZFNCpKtnWasK5Y+9jRrfXC4VnGnLdyOfRDhViBs/EhI+cz05P812pjCtG
	kQY4NVXE/q1Ns27O5OahfHImPk6zGgTqaz+SxZfjo89086TkEm4nSNBhepY+U/Xk0gvxm58ojOV
	s7sOm275SgoD03jg6G1b622xXBIE1jSoFMqk1AA0odyV2iCVFh0UWDntAxtCL2n4PkroJNLQzhU
	jV3ZzQ3r9QlTDzPpWAStHb048lEPghYVUDlzGwzSyMs2L8mWFjlDOxjXJzfJhnZCErntASlkIIs
	2ei5/fy5fjFxH+nbiKIBbrnbu9rtkgtMffF4R6+/eFnrs/E2IJIkkqIcnZCax0WC+EGjwbbaixf
	NnRBJWT4tc5x8LCEasBPTUaddor01YvA9oleq7zZg6og+nabP8AbskVk9HJL56G8qIdJVNrHMa4
	4QvrcgWAcYhx/T7kgh1lGGj5uORo/XdcD1067rmIIMwFaoYtrRFcgWtIe4ahGRxDnNQXAwnh2xV
	35J0UVaInUesLplP9JGPrkqRsr9cKRsEEY2pEA=
X-Received: by 2002:a05:6a00:a01:b0:845:ce5f:c926 with SMTP id d2e1a72fcca58-85b59593e6dmr8525461b3a.1.1788245942189;
        Mon, 31 Aug 2026 23:59:02 -0700 (PDT)
Received: from localhost.localdomain (vmi2317720.contaboserver.net. [84.247.152.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be5ca747csm604072b3a.5.2026.08.31.23.58.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 23:59:01 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Tue,  1 Sep 2026 14:58:35 +0800
Message-ID: <20260901065847.42869-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831144732.80910-2-sj@kernel.org>
References: <20260831144732.80910-1-sj@kernel.org> <20260831144732.80910-2-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ and Asier,

Thanks for working on this and for providing the server results.  I have two
questions about what hugepage_mem_bp is intended to represent.

> Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP auto tuning. Add a new DAMOS quota
> goal metric to measure the amount of huge page consumption to total
> memory consumption ratio.

First, NR_ANON_THPS tracks anonymous PMD mappings, while NR_SHMEM_THPS and
NR_FILE_THPS track PMD-mappable page-cache folios.  Therefore, splitting only
an anonymous PMD mapping can change hugepage_mem_bp without physically
splitting the folio.  Is the intended metric PMD-mapped memory or physical
large-folio memory?  Clarifying this and adding a mapping-only test may help.

Second, the metric is global while a DAMOS scheme can target one process.
THPs from other processes or NUMA nodes can satisfy the target or dilute the
monitored process's changes.  Is this intentional?  If so, documenting the
scope and testing a background THP workload may be useful.

The temporal results approach the 10% and 25% targets, while the consistent
results overshoot the 10% target to about 20% and 45%.  I would describe this
as control-response data.  TPS, latency, TLB, fragmentation and collapse CPU
data could further show the workload benefit and cost.

If I have misunderstood any of this, please feel free to ignore these
comments and correct me.

The enum, quota-goal wiring and sysfs exposure otherwise look consistent with
the existing DAMOS autotuning framework.  I consider the points above
follow-up questions about semantics and evaluation, rather than blockers for
this series.

For the series:

Reviewed-by: Lian Wang <lianux.mm@gmail.com>

Please feel free to Cc me on related follow-up patches.  I am happy to help
review the code.  Besides my own DAMON work, I have recently been reviewing
and learning from other DAMON and MM work, and I would be glad to continue.

Thanks,
Lian

Sent using hkml (https://github.com/sjp38/hackermail)
