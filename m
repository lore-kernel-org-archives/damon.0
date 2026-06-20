Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F90199949
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 00:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781915765; cv=none; b=IE6AnZvIBTiGr39jS5Fq7/OwzK8RYJO9aXMFNyA+kqnu+0P5UPe8+R6qPEonxMPD2wxEZnHr7YtQy97NncB/j/5/Y3jI8XYtyyCbtuqGAg28PGWh+zMt68Aj504b62Kk6NgwCDFyjqtpOfE1sktuztKJPFxW1IIdOtCA+1XqkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781915765; c=relaxed/simple;
	bh=vno3oObMENIImjf3uX9yhXtURG/6ZQ78f0PME+W88Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfI7eV9BM58WRvUE5WGfoXdlJFE0gukKFpfViTxJRL8o/PIn0lKmzRYDdoGk6/mdaolULS24wcMEhfmilEnY9THFOm90kW3tozfy9F2ONLNK4+HobdgQ8MPEi3fY6cOVnqd5D5MuMTyWSe1sPAwhQJtIBQc18P6APOc1BNpNcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEcHPWN+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEcHPWN+"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef29c5561so1524096f8f.0
        for <damon@lists.linux.dev>; Fri, 19 Jun 2026 17:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781915763; x=1782520563; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZGHTu7ZWt8+LY2ZTmgpTwhyxwOuYUCiNXzS8M6bQ5c=;
        b=jEcHPWN+wahkgHDe2b78CTK8unw3a5TQpgFojorR0s116j/nFjc7uitWzadGz2U8/W
         WDbu9nOso+aoIQk+wMDxdRxcRJeD84Cdg9KZ5gB4cP7clmJQx5iJVEYA7cb3eSDpcP9P
         iZVhPUczMw+O7oVwtxTbUWyWeM4z9TwBOPavManHLqri0vcsY7nIYl5tA8d3pNBDWisv
         XFo+EAODe6V+zaJ3MjlGcnz79jrm3vPbxy3BjkRWTYt+6Txj4upC8chKhGrDJPumAn9P
         RauPRXQJyL3fi9nzcMITgzBrtgjAW+/2WHv+wyQdDxoMh8y3mjVKkJpDNkH0soPpVmVC
         0wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781915763; x=1782520563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lZGHTu7ZWt8+LY2ZTmgpTwhyxwOuYUCiNXzS8M6bQ5c=;
        b=JzLFbPTtH76sJoOt7vW7FVshzoqjpDeEYzIc7Bl0UhKdMWgyofzOYb/m94D087/JEd
         HuYTcdgfXrLA0lpr4ikGn/sWz+nVnKeH9j0jj052hxR4PdazSQ6d+X49GjpnTwLppWAL
         irvPcKhRcVA7hAio7/lUtJ4n1zgEgStW+UYeoeIBdP2hvJ9MckdPCPoLQ8yslNxvRWr4
         cXGNY+OcMIa68ABiI8AVgMjCbZnBiN9eao/w4apXfd+rz06+GURCGsHXTQ8MUS+LQukU
         0OHVnSzjEJd4+7mJUGKtT6kfZIFS/XdtG4PwwA0Ad+jvp8bGeTzn+PMj1sEiXrTorCKD
         ulFw==
X-Forwarded-Encrypted: i=1; AFNElJ+fGQhZ9pX4FiwsbqtWELV5oLVk8czZ419mknaye/KO7OfEzSbwvudQqlLlpAIllW6OiLvigA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNyUDBHnHrQr+FVY6MENTTUMQ7PnyEcNCCUSrbpkrHehtKcX2B
	/VCh86sKOjqDiRGJwDfMvkzWHty5eGpkRGVFL9oaAHkXYFmWFcqPYhki
X-Gm-Gg: AfdE7ckqS9YXo7qS5H2cYA9G2QG6g1PRQZKDYCRClHsFv/exNTqb283pEO28pJlOK/X
	c2N8280oSyHco35z2DQLsJVsgp7pnVCww600JRSXxZJzG2w2RDbfqAOhw0uKjNKwL9RQ2aG+CQC
	e8DoaEXiYa71CGqG2vkB/rUwGcTToDPytVXvhLWEDVThUCJ5LchNTQ5eNwzbUk3CiN30NxPR0M/
	Q8XlPYEME7QeqRWm7er3Nq1ydb1mBH0hB27qDi90VAGprLwjgUnKppQJ83o2Xj/TwrrEP7h/xLV
	KNsE9M836Z6IRfSFRJASsV3ue8LenavnGX6IBYOk9axB9At3zkmytoTpYAJ/U94HzLU5ENZrBeK
	8hmfvaA5sqh6qXhDOLTCs6iZY7V05KmO7P7dSkBa5UdPDe1T4dHOACEtifwbPI7hNpX+oCasHwz
	olePdhR9xQPESAahUV4prCtg==
X-Received: by 2002:a05:600c:4e11:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-4923f33d921mr101272725e9.15.1781915762907;
        Fri, 19 Jun 2026 17:36:02 -0700 (PDT)
Received: from user ([104.28.163.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494497ffsm22020185e9.11.2026.06.19.17.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 17:36:02 -0700 (PDT)
From: yahia <yahia.a.abdrabou@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yahia ahmed <yahia.a.abdrabou@gmail.com>
Subject: [PATCH v2 0/1] fix initialization and parameter issues
Date: Sat, 20 Jun 2026 03:35:56 +0300
Message-ID: <20260620003557.243313-1-yahia.a.abdrabou@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620002614.83004-1-sj@kernel.org>
References: <20260620002614.83004-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: yahia ahmed <yahia.a.abdrabou@gmail.com>

Fixed a potential memory leak by removing the
early return to let the function continue with
out and set the ctx variable to NULL to prevent
a use after free, In damon_reclaim_init() function
if an error is returned, the ctx variable is never
freed.
~~~
Changes in v2:
- Remove early return
- Set ctx to NULL to avoid a use after free
- Fix typo

yahia (1):
  mm/damon/reclaim: fix potential memory leak

 mm/damon/reclaim.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.54.0

