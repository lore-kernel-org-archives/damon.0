Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422054A2A4B
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359759; cv=none; b=JNy8FSRPKXKIfOUR5QVIgWChOKPrt6YqPHWHf0dFGVAXA6MWh18srKR+/2UwwiQto5iRZVAPQVIqes0969pxvv5rXhIfka4DWFbVHj4dXUCEcpK7Ml0ih+z1oScSJUij5NpCoH+Kjqe7GtrAZXOb/p1HBDgFctCPZ653h7HQfUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359759; c=relaxed/simple;
	bh=6aOkKqHhym80a6kBJ8PrVxu95b/21N9MEjLfSv0uAm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJ0t0onaaZxZ/tyB00IxNQvJOoAabwlEAqyo+7V8n7wqI4430kjHvaxJG/IGfs1AALfquLvLe4BZQ/u7OOdaqYaSvIstrTdqXil9FB7+YhCibfrsTLY9ongPFv93rZnvvD0v8rGH44UL9GbnCl7Q9DaaYtd/1Nah9ors4WIa6+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuX+fhAa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuX+fhAa"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8557c3f270eso612846b3a.3
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788359756; x=1788964556; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hr6y/ERn9mwLYkItat9vlE3A943++Ow9sTB6oJwTNEA=;
        b=UuX+fhAaxdMDIg/UxTW7v5oOrTcAUgqD5QbH0ISgWdsthfrDbhp08RPcIUC1D/r9fx
         a8ZY4fu6ELYeeoZRyJCRoqKx35P3uvOIWHdqOfdB5tWs7ZAzWqVKuBV+5L4QdpluzJhC
         yixnMpZMHNhrBJxD/fpYWItcWwwOwCemY/bizd4tlwWhNetslXPMa1WPGQ0Q1ZZWj5B5
         AYsjFxogrS/MQeMbQTsw5IV7d8ANkavgvTs9FwilgeLsW2Y0dvZ82OXsjPnsOv74w1tA
         UO1q3lSrvo5a1Psc/qudjF6nBpxM79qTb9jw9L6f7Gd0WWammTmRLjetG1df1Zg7HghT
         rwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788359756; x=1788964556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hr6y/ERn9mwLYkItat9vlE3A943++Ow9sTB6oJwTNEA=;
        b=LCIkJVc/2WX7e2S/5XYVMUd/VP6UQ0gOpAGuNV9y1OFWhkthifYYVcGaxvUShvLPnV
         tqrSZKmWVbNEpzZfr6Hwvgz5i5yi29+S0ikpjHXpjmzcDl5If+gQ2O9CaF0RshGQ0I05
         P5nF3wPpDPtpBCx5buEUM3tcTcdJsb57slsH5cZaSw3deBaqXU9Ss5vgho9sHj17WROJ
         hU6XDpbkoeV5ab/0L17HJ6V2lZzbXC+hVyLrbfX5EoCNbkasQuztvU7DVl5inG21fkKO
         H9Qc9OOfRTzikAZT5/HrERwXHM+RWiQhLvgsV78Y0e/GdBVdgeztwPAty/hHf62rhmhQ
         dTWA==
X-Forwarded-Encrypted: i=1; AKwUvBzsLByfoioJBbcDlx/TZp916/qiACoODUY12bEOCo9hSwDfqzmW58mubataq0riUWEu+OPrKw==@lists.linux.dev
X-Gm-Message-State: AFuF++nhmbFrUOghp1h5CI5HOfyYaoeF8Dl78C3O4uD4QuY3j1FZFGz8
	CCZk3mVMSVu6pf83KgiSi/XiWGS2giSjedukWN97aIwxRzkBRzDYqweaMcogeQ==
X-Gm-Gg: AYBFou0RDW8RCMpaU7e597hA24u/rQS95PB3SoN7wx6Zqgifd26o7V5qkQecWaMzdr1
	49lg6Jdv1vB4owuM97SlPfkFSlQaq8UTa14U9Vxo/L0NcbB8XuGvEW4gESMQoXi0gYRvsYpa/9Q
	xnJS0w97BepJUcn31LQoQ4eMNicK6yiaoKnoVzgcMjFjpJSCG7Y4c13v1XaKbjf9qpqJG53POfv
	Hy6Ma0mlEXBab5MNsxuScn2SZHKKyI7Vrp3n+tVx73oDZR488pVyM+nnlNPxTNbyqQE1r1WGUNf
	wYYcBlg8Or9nENr+gLW8VoK2UyGxD68KsRqov78YtSuXd2GQiHCKarFy9xbLe0Es+PboYRu1ZK0
	v1YnKDakte8Pu7swlMOMdgs1dycnA8utyREFogZYMcG0Kd4c9dOmIiXc96x7NHk3bK96T/93qnC
	LmGv9lb1Ov7GbgT9Ootq6qpDqSPK/ilB0TjD7yvfBtuMKY/b08AuG5yeuCqvbjTnorCh3CUkU8z
	oBA9SjYII8zDYDW
X-Received: by 2002:a05:6a00:1c9e:b0:857:73e2:9104 with SMTP id d2e1a72fcca58-85ed94bb41amr7949304b3a.20.1788359756325;
        Wed, 02 Sep 2026 07:35:56 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db24f2076sm1560348b3a.4.2026.09.02.07.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:35:55 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: allow esz to be set to zero
Date: Wed,  2 Sep 2026 22:35:20 +0800
Message-ID: <20260902143605.6785-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902141349.86896-1-sj@kernel.org>
References: <20260902141349.86896-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 07:13:48 -0700 SJ Park <sj@kernel.org> wrote:

> On Wed,  2 Sep 2026 16:20:50 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > When the temporal quota goal tuner determines that the goal has been
> > achieved (score >= 10000), it sets esz_bp to zero so that the effective
> > quota (esz) becomes zero.  However, damos_set_effective_quota() clamps
> > the quota to min_region_sz, preventing the quota from ever reaching
> > zero.
> 
> Where in the code it is clamped to min_region_sz, when?  And what user issue
> this can cause?

In damos_set_effective_quota(), when quota->ms is set.

'''
	if (quota->ms) {
		if (quota->total_charged_ns)
			throughput = mult_frac(quota->total_charged_sz,
					1000000, quota->total_charged_ns);
		else
			throughput = PAGE_SIZE * 1024;
		esz = min(throughput * quota->ms, esz);
		esz = max(ctx->min_region_sz, esz); /* <- HERE */
	}
'''

This is a minor issue, the main problem is that it doesn't match the
description in the documentation, which states that if the goal has
already been [over-]achieved, the quota will be set to 0.

Original documentation:

    - ``temporal``: More straightforward algorithm.  Tries to achieve the goal as
    fast as possible, using maximum allowed quota, but only for a temporal short
    time.  When the quota is under-achieved, this algorithm keeps tuning quota to
    a maximum allowed one.  Once the quota is [over]-achieved, this sets the
    quota zero.  Useful for deterministic control required environments.

Best regards,
Rui Yan
