Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC03A5E6F
	for <damon@lists.linux.dev>; Sat, 17 Oct 2026 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792261343; cv=none; b=J7N9peQ8yHldP6F4GE7vamCyrX6MXMW99Heo0mz4Pj0WDYpke8oZcWGn2/vNUvPc7l9XD+QoOdZ8TD3nurldhOV+aZpwHiYwFJR/KCZEnbh+SjwlR0LZ8EaEiB0IGNqqwgu5SxjbhySZ94CqsaOLf1rdyAjPBNbyzvTTlsoNPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792261343; c=relaxed/simple;
	bh=/Vfijf68A+VL6uUnE4Bt+H7Br2VEyiv5+2DKxOHEMfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBCfZaADGVFPinyiESWwc905xp9IX8easAZI9ctRMl0qy7wkT/A7RwcD/VbonmMhSFjznQsqTkF4zUITu6IXua0aKNG8bbmROwKO78Ej5BADQzrM19g0YT4KBEx7Tc6jd6mCGFkruT2iVbBUdLHRGFh2xq40GLSGiGFDG/DggKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vdb9yto5; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vdb9yto5"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-354ba08cfd1so1345094eec.1
        for <damon@lists.linux.dev>; Sat, 17 Oct 2026 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792261341; x=1792866141; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Vfijf68A+VL6uUnE4Bt+H7Br2VEyiv5+2DKxOHEMfk=;
        b=Vdb9yto5MlXbUFgZsw/8jfv/8/SwBClXn5gGpp9J1DAWJ5YS1r97goWNLIeGnpOFAz
         Sj9caciLg+SRugxh9qKw2J2ZLhRKkoapPQm1GYWIWaZ0XAkHTOAEO7ah3Zszag/zVXpl
         K6HTkgRUbuD+yrICVMEnfKmUjG4+qjPU8NfgVMpqFZWzCNpHzOdxvAaVndrtmjt1bI6Z
         jR6jkoJRjgSNZ7adLF96Tq9w61CrFWFLQv0hQCbaTX/b2vtSeVvTbxZBlky8vYNjTufh
         sBlfRGEW/sK9SPr/nzUklX0E7xqCnngz6ALkSjrkTHQgFQBLYLRjR7BoCeiaX6bznReh
         PVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792261341; x=1792866141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Vfijf68A+VL6uUnE4Bt+H7Br2VEyiv5+2DKxOHEMfk=;
        b=hrC8TyAEFdIvoPn5Rdmhk8liCtPKcyR0nmnIk2y/QlVshEgj/A0gt8ufAjd0kUPRJL
         TOtzL8E8TncJvWeN/if0F0nHhes4yxx/SWFA9b8aU5AnfQA1lZLEoBgdvUDXvgnyfKRs
         0r1KPVu4dfl6htGtdr+7ducP7W4Wxdq4v4e/T5DdZvnnJdb+1YSZorOS5tQVrU5aw1nX
         XhtXIpM8QUja5rkzuoyn37Bj6Boc0P/hGEeAMb1pfZLNdQtaBj2Sg1t4oRrTsCuReoLm
         eYl9aS5uHAvfHNaU4Yjx3MMZeWyRkdw67tgY809GEGbbvE9HHDoy1uL3oGulhkoqJe5P
         mMrQ==
X-Gm-Message-State: AFq9FYKel312pB0RDM731eUwd7znpxXN1dChJ7rbjGb677Dop2LNijYw
	VT6u/5yZllhrCjm/bRRnLTSkMcs+bWxwcPD+smirDJalR8eHVrwGsKd6DX7uZfJv
X-Gm-Gg: AYBFou3fE4KpNn++SiH6IIRVRWZs1zldTJqp+8TEE0jf/B2PWQdcnjyAcVg/wjzsXWG
	9+rIHPJ1Kik2YsefUn05RdlrTtyK4iDfz9shDRq+TeFLUGysHJxk3+Q9iJMNWv8bJzbVPYLGluz
	Ii2JafLeW248BZWSkYIAzh0TM/g2b2kBoY+y/9jh1fra+NRAS2l7VMRfZXBfJ/NKbZkdc+YCLZO
	6uMqjLwTPok8A9ylZnBMtQrni+sJX+mhL8avmRnlDe8uNxkVywM8Hz9Vpt2rPxs8DQtpjQ5L6AS
	+xeFXryhtxqj+sifw+AD0r94qjPyUxAuuWSVCVQWHHxRW9jgyoX6VEmpCTU7/vxNL9e8J2beACg
	c+EN3ddSvnjmeaSdzT05hCPmxGQEGivCV6XqRTWEHG+Srh6yPWGfFsBsBsxCdHJRpZkqHIo7ffH
	ksChIXuBAOO7SztVrjLWBxLZWO6JQ2T9KYu6xG2TnMbbSM87o6dxTzzp9ewXS1UXA+fp0ZGyD8P
	AKImvHeIolA4yvtI+OHtkHwa/xagCNGcVPxbF16cDdG91s/p9E+uuz3klX5jFjFqtByImI+4xgq
	bsjRdBIKSh0fwMIlDJ7snkhgN+Wy1IH/SVxaqZQ=
X-Received: by 2002:a05:7022:1583:b0:158:b51c:4502 with SMTP id a92af1059eb24-18512f1ee00mr4893761c88.34.1792261340848;
        Sat, 17 Oct 2026 11:22:20 -0700 (PDT)
Received: from LAPTOP-97G9G880.bbrouter ([106.51.148.253])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314b16f57sm16272585c88.2.2026.10.17.11.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 11:22:18 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/sysfs: make next_update_jiffies per-kdamond
Date: Sat, 17 Oct 2026 18:22:12 +0000
Message-ID: <20261017182212.1450579-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017160143.102364-1-sj@kernel.org>
References: <20261017160143.102364-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

Yes, my patch is redundant. I should have checked your damon/next tree
before sending it. Will do that before filing anything going forward.


Karthikeyan
