Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A164EF121
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737214; cv=none; b=qHfLCGnt3SQhBSGMmokBmATn/wnkLuXyUovGY3fzCvUluUwfh+rPHrEgsSzbMFy1KS7PXWS7+sz9PFCBDl0grRSHj4ZH1ZfrgAQA433M/YJMw0rGrEhCeZWYE1BDOcG+PQ77s/FAAyj/xcWO7gOC6wbUyaNlWtEd0Ec/LUGrPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737214; c=relaxed/simple;
	bh=1QC+jwsNR5PAa1skLhSCnS7G4xuOoA/KikoCWPXFG+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeFDl+NuauP7IFr1XRk/WKHW1r040TW1zxB1FPqnL+Ip3YHGZNuAHtqyNhchALNazUCbGrQ9vjrgPMIYNlNGnH2JDIGAy5rltbpnlSFYV3bNccZzzO2cJCgVV8e1dFay5toJswO3jsrwhj4q3KYVwZmX2xzXICDT3NtlGyhUEY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDbnc8W5; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDbnc8W5"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso730979a91.2
        for <damon@lists.linux.dev>; Fri, 18 Sep 2026 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789737212; x=1790342012; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QqKItCu17DpUKMJJO4kJKCuEQNfwXM7mJRhT2VHmkuE=;
        b=IDbnc8W5OGrmP0/kFkvr6vj5qPmgxUffWOmgd4V2Hu3dJd+TpObRltT66ANAoDcihQ
         ErBgLwXZnIYgquQKmRyMJn37F7ymMa+1vABuHzH/2FtESzYce2iG0AqJbEGlEvGfzNJG
         reyE7A/FgsgveOH/v4LZWy+xXEmV22xGdRpTg7IplDtmosl1RVlje6DnJVzSNFJvasUR
         Y/KM0tHhih+ybPlmLD67+BNmIz6RQtyaTeGaOkqb95krdxPpQ1BPeKJicwIQ9xdu+jWI
         9yw5iX/bcglYVN87RReZbYxxE5nv9/HoplILfV5/YdP4Y7ssjdLo7pw6HWhcrRX8zPdG
         McFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737212; x=1790342012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QqKItCu17DpUKMJJO4kJKCuEQNfwXM7mJRhT2VHmkuE=;
        b=mP6a3m+ndy8y23famBFV+hiL0m/F8l3e20vYAa4gM0tz/3OyPmBIYz7/SjxK5NZu+8
         1ObNEAo8Yir2UpzS5/TDF2X3nO2b5rHZ80s6OXIgBlO+xEeWa+nFScuSgBN8OW06CwxG
         gnfrRTzUGcudDY2qpLLQaE1we8qAN+t9T1his5bMlCmMsoxxgygZkFxlm3T207hBC4k/
         09/d9W2Rj/OeZDtoteAaP/S/N65QZLUatPv2wIuQ1ow+xBlvM4xZEwNrsU7LXIQftdgJ
         Xf1SD9DmHnkr09WFVsfoKoHibmG9nYmYxlzceaqapFIgnf/m6NZsMcwBfmPT1id7/0qv
         ih7w==
X-Forwarded-Encrypted: i=1; AKwUvBxMvos7Q6zZ5cWiFsUnxLBnUJuMXFjpKAh/pQ8OJyJUVgJEad70bJmiOsOPWxhitDf3+RXJCw==@lists.linux.dev
X-Gm-Message-State: AFuF++lsBwTSMDd367JYZyRICMEzRW6uJgdjvUoPaO17e4IGiwCOwyHd
	owsDC/KNTIsUpFH4Gb8pDEvezIIsex7PWe7wUQ4TcF7U7BiVrav2PcaB
X-Gm-Gg: AYBFou1B9DU2YS79er/HB0I9YHEKAeDeT6lQctp9jjxI2twX29wWC52xGgPZlzz0CAl
	cUKBfAOIef7XVfTAnlgadYzgACKc/43aACYqiR3RtnO/ygOu+y1DjUPW7rtIgY4IeKhKpQI2oJQ
	vseP27mTmd+7eWTm+CG3SLv6CLnn7noMmW2vfnkDEoD5oQFDLTyPDxC8L4MxJEEt8WF1cqtBDU3
	qUNCZVUV3HLK3casgKV9Kg9aFL64EUJuzJXpzNSVw3AScSA2uNU2qZHDDDahwf/iql2nbpMB/dY
	nq9NrbO6G4uGPpMDb4/9UeSZvNi54MkWcsOtiEkXnigD5vf3fo5akEZaO/gXAQXihux0EcYXlIJ
	dEji0hCmFTcsmqUfjTxuzVOBKs5505vdY2dFOl5toNOJRO5ZT+/0ngrkzJyJnjQYAzRYRupWDPD
	kqwxNo/tNvacqXrzoO3l8nD61PWRaYyI7HOfRm2/K0M/+PmqKCtntQPZUaabe3e6IJmjiK2jFlX
	IqEPwlS42cONnDQUzNOshymRcM43QU6T1yDLtAbzrx9YBUvWFu76eXtuywNpnbHjDGB8FOGL9kS
	VhComlWTYqb14AVQmnwJtiw2g3jBprSrAwccSQqkiHv93eILpUZkV9D5
X-Received: by 2002:a17:90b:574e:b0:39e:1fb6:9659 with SMTP id 98e67ed59e1d1-39e54f0772fmr6160682a91.22.1789737211777;
        Fri, 18 Sep 2026 06:13:31 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.202.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5a50cd09sm3259882a91.7.2026.09.18.06.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:13:31 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan KS <karthiproffesional@gmail.com>
Subject: [PATCH v2] mm/damon: document that a zero sample_interval is accepted
Date: Fri, 18 Sep 2026 13:13:01 +0000
Message-ID: <20260918131301.75879-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918023859.13556-1-sj@kernel.org>
References: <20260918023859.13556-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_attrs() accepts sample_interval == 0.  This was reported as
a bug in v1 of this patch (rejecting it in damon_set_attrs()).  A
similar patch was already declined for the same reason: a zero
interval is intentionally supported [1].

Document the behavior instead of changing it.

[1] https://lore.kernel.org/all/20260722094304.3132750-1-dayou5941@163.com/

Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---

Hi SJ,

> I'd prefer adding a comment saying zero sampling interval is
> accepted.  I think damon_attr kernel-doc comment is a good place
> for adding that.

Adding comments instead of code changes.  Let me know if you'd
rather the wording live somewhere else, or be phrased differently.

Changes from v1:
- Dropped the damon_set_attrs() rejection and the KUnit cases that
  tested it.
- Added a kernel-doc note on struct damon_attrs's @sample_interval
  instead.

Thanks,
Karthikeyan KS

 include/linux/damon.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0c8b7ddef9ab..1a7ef416ec46 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -787,7 +787,8 @@ struct damon_probe {
 /**
  * struct damon_attrs - Monitoring attributes for accuracy/overhead control.
  *
- * @sample_interval:		The time between access samplings.
+ * @sample_interval:		The time between access samplings.  Zero is
+ *				accepted.
  * @aggr_interval:		The time between monitor results aggregations.
  * @ops_update_interval:	The time between monitoring operations updates.
  * @intervals_goal:		Intervals auto-tuning goal.
-- 
2.34.1
