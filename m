Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBACA48F85E
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400189; cv=none; b=bimrU3/qzc1FegJK7/9VPOGQBJvTWWkvVLn1CWpdCAmpIB9wJMRfmUWswr3IvxffW9UuCPtPqbliXcv5FJBwRCqX6zRxnIhRvSAkVPueqGUwnNX9t9CDecydZ/BAawJIHRocEMIJUAXdmh07A6iZcNdLZftr4tGVSvr/QVmsKFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400189; c=relaxed/simple;
	bh=EYWGaZYVE1lvN7l+uwwCD0OFmKQBblt1jdJNNOZ88OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXftLhKQZojwNcre+IFn15LhnVxc+eDk6182VuUoRTRTqhDNHeRanU4KiKNSmlILQez5MklvxzwSKnYjOErMiNrWlpw4VWBFxV4BuorSMGF4GTrfNkDzg4XpkZicKF3K1i6l5yG2SRvojE2mN1zisvAdvfzLgyAt+WOcJbPj6+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRxQACuu; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRxQACuu"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb5so1838870a91.0
        for <damon@lists.linux.dev>; Mon, 14 Sep 2026 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789400187; x=1790004987; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZuYma/Mvt8YazFkYyYSaJ6fwaVS0ky7SQWLme5KxC8I=;
        b=sRxQACuuSEbMkMdfKq12DUL8JrQQjUMHFfuj+R9DLFMEIwumVvjTGO7IxGWNF0Zxn5
         rL2jjA127wSGSO+vU4CIvnbJBWgkcJBLFuaLE3JsPAkupf4RcRCs3cD09b6FEOWXjqGW
         tF8a5rCfU7VuPm2neYIVhVBuZTlwZZI1UAJVz7squE5waQmmlCDg7Uh6qWQTuzbA8FKQ
         6pvS1rLbyTgZX35R6MFCDEGRFrfb97y+x72HdUoxcuwNF9YelYcCJ+Lp/iJNr8IWwJlc
         vrmwYlT1Th/NJ1dHz0ZifeFtnmzpjbUY2Q2sHzTaGTls78NN7YyXwcMr1PgNksotw81b
         Cdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789400187; x=1790004987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZuYma/Mvt8YazFkYyYSaJ6fwaVS0ky7SQWLme5KxC8I=;
        b=JYVlut3jYLH9R0a7+FFN5OH/LCooasVGUzPSaXioypexzaZnCCVBVCg3wQnjKDdWZh
         c9UdVbJfCWb2WIQ3Pjp+12p167EnIOl+n4ReuXmSUZuZ1nPr3MeYvXRCMO98k2oltHfS
         bbe1F3yGnPgdnynZo578jUVw/TtenNSEBX+aAyhReIaiD7q1yJP2270PGs8g3Vm/z8FU
         insEF+XK9AN+ZYSriSdj3hCCpXIrfTMLRUjisRcQLGd0MZuBuqsq4P1hCqx4X0Apdv29
         OMwtAQs1KuYy7XdFu+TkT8DG42Xhl5JV61XWWl/KxmGFMNDwIOmX2JBMP0UwxmZfIYaT
         1lBQ==
X-Gm-Message-State: AFuF++l3pnRvHHws5IxsQUGhOZM1mkf/CpHIa/FSUwCmICos4+agJPni
	SLpIxm2VSbRu85hJFvWcxeQaDX3QhiaczjuBFruu1rcLDoj98IHh6sPl
X-Gm-Gg: AYBFou13ficqrluWbeYHQyl8AzwgiBcijLoekgPhUf4Or1lioC/lWl/Mt3LPly7y7J3
	ek3cfHjXhHghUfOzlno9kFyxYVQGZVeGuJp9mWPdliNjOucyoSTTU3GHGqryyMcXMETerB5Tsop
	yu5ulh1/f0iYgtzpuh8PHwlgKCoZntn0z3KXLktKrLBuPPzC0znXSB2eP9QJe9nMi0kZk9FwN8k
	PN3l+Bwt9BaH/KCUATXfSn3iB53O4sIn1yg0kreyFDZMWr7+hOjNOPBeX9u3jZcEMTEQbU6AqRZ
	BbThvz9NJrKHZzgL4VWXZxur9HdY2TR3U8bE9PX3luVypJzZaSmMuInhQMpIetbNT4zVoCjfqTx
	LbV+c/Z3eeuR5TRuJLXJ6Ovosdc2uZL2syPYFWdmNSdOkgmL9AES56oYU+ltACAEHLAq33ND2Ce
	/fQ9fskrZZCXYyxEDMKm1xl5Os2A0zoslXbjlZ1+KpHzHNWd8qQMU5hz3I62zxia1uJCDFbh5Wl
	zI=
X-Received: by 2002:a17:90a:1002:b0:39d:eca2:5c81 with SMTP id 98e67ed59e1d1-39deca25ea7mr3712535a91.8.1789400186941;
        Mon, 14 Sep 2026 08:36:26 -0700 (PDT)
Received: from celestia ([2402:1980:8858:8cc0:7bda:d54a:257:22ec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfd6b9687sm119410a91.0.2026.09.14.08.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:36:26 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC/Discussion] mm/damon: Implementation for paused kdamond
Date: Mon, 14 Sep 2026 23:35:10 +0800
Message-ID: <20260914153640.8481-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

I noticed that the current implementation for paused kdamond is
periodically applies online parameter updates by kdamond_usleep().

I'd like to know if we should change it to waitqueue to achieve a lower
power consumption?

Previous Discussion
===================

I noticed that when you introduced ctx->pause [1], Sashiko asked the
same question, and your response at the time was:

    "sample internval is 5ms by default and recommended auto-tuning
    setup makes it hundreds of milliseconds.  So I don't think such
    change is required."

I'm curious that, did you think it wasn't neccessary to change it to
waitqueue when it was introduced, or it wasn't neccessary to do so even
after it had been introduced?

Asussmption
===========

This is just my assumption, not a real use case I knew:  When 'pause' is
set on an Android device, user might want DAMON to stop running
completely when the screen is off, thereby reducing the load on the CPU
without losing important information such as regions and age.

The current polling may make it harder for the phone to enter idle mode,
resulting in some unnecessary power consumption.

However, pause feature is only present in the stable version v7.2 or
higher, and since the latest Android kernel is 6.18, this highly
unlikely will affect any Android users.

[1] https://lore.kernel.org/damon/20260321202858.98091-1-sj@kernel.org

Best regards,
Rui Yan
