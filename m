Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB13AA1AE
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 02:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789092060; cv=none; b=JLyZ7hNiQuExP5CBQqHa9TYUHZ9e1mMlT6wQ7chc3Hm4c43vx69fHkEzcW2YdOQ6pnqkJ5dduZnEBkCFlWt4Bup3wALLNVuTjxy8/6Phx0K0LnSyrvHfitxjYtBufyJmaPrC5XmQZGVv2Su5os7KLt6IVBR76VYlOjiU8wJ/1ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789092060; c=relaxed/simple;
	bh=wp0r7AgCRJS+78I9gN02wWq64Qe+gJJTd7gRl1+NHX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lysWhxnqkWsIQ/B0sOi3kkh+Ca2D6OWtLPCVq++F5Hrs/qp2Hs5qR245D4/gcNVwKp1qYcs1Z/lGQk5Fn4BeyFJegWP70ayKESwac47pi7/lq12Hy7dXn6IqT2s1BJxoUcOkf8+tzD90+0LlnfJkh76CJRfxzY9cYwyEaT96x/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa6HD/KM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa6HD/KM"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso391208a91.1
        for <damon@lists.linux.dev>; Thu, 10 Sep 2026 19:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789092059; x=1789696859; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i9aokmFcZIJ0AXOYQkqpTsd2jezFgj/8e1f52oVYV64=;
        b=Sa6HD/KMRwATjo0LpApXCktWsOydXxqQVolVQGMk4PGo+BEFQilLnQil2ailuyoDQa
         aDISg51qh8Vu9XcaLxo9t/9iRBf8PUi/OEXx8KWOIVTgrag1+DyZcTyr4ot4VgOdzZjQ
         q0IjzP749DHXVIEk/G5S4pCFwXNiygWyOAJN+Yy38QNyU/jP+msYpMHqZ7pYAjbDJKj9
         XG/79M1ikWriel3uHtfGZH6QyZDlvb/b2tBatX+vV6rkzVbn9+NASz7dcrSBOmOZqFfl
         zMgFdPyml7T+8fhNL+vvnjz9q12+VNayZEQPKUVkY4UtHjNk+/YbLx2H4kQqj0lol4y2
         i/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789092059; x=1789696859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i9aokmFcZIJ0AXOYQkqpTsd2jezFgj/8e1f52oVYV64=;
        b=gJNM5FD2ftGmT6DUUereb3BNEVBBj8T9KaHx6C+vzAu9B8f5knmsJAuqiONOCYkdVN
         HNX1OFsTZGkZIw9IFzOv5Avnebe5DGXOFRmj1Wt2I7EhYlB6i6/fB3h4MbbbU4o+sMGc
         m4cC2wq5vpF+MyliMxaj2cxi/IcETdqG4UCs9b8WijiDMyLu6nVYtiMysx12T7J48ydR
         f1xD5pWA68aG9wJT8mENX5XuwZQTkjFpm1RpXxZc7MCfV3PJwHkT7IYzuOVRK9ErgJSr
         sJ7R39/2F+ugdoARW1AJEqu0z7n3dF9ua8LBJeuszVJTUcDSyMmQqSuuENJmaDguR6Vz
         74Pg==
X-Forwarded-Encrypted: i=1; AKwUvBw0610YRoaH6fZbsla8ikDFzUmkexTjSY8s5TX7fuM1ZtQ4+r9jP7DpzVdfQgbKj8FromHtBQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lg+ZFxqmVEshCVIw4NBahECXFNB+5Vf6TaUne9KIx9YseA/NR2
	xnFwCSX8mS1iAYYuXjl+EG5YhxhL/0JAqG3u/cPeGwK0vNuWwDkl3uPM
X-Gm-Gg: AYBFou3mGkcD7lJ0K6VOBIssis21Y0b41aqY2uheWn4YWYbAxKGcveeYQpa8NXZkboH
	2EgaLJkqWXm0z3Ni96AfWKF9G6KJP2RsON9LzDfangELigm/FpBthL8yxyY/18DIuYZjByb/mpf
	5Z8tsSUT2FqzYlgoH7ecREiG8KXmKlextaTxzDedmNdMGlltHQh/Yij+Jxz0SE1N5igRQvNWCLZ
	kPRMfCPiIq/OMzfyRomlwYWpYzkygwkndAkP3KoDzi6Y2UoZLd7lkdcFCGcwQowHFTPWX05JUF5
	mu7D+0BzbltAHwzggPth1aXpUCfFdh8V8Im2OdHK8cpbzkn6kh3DDeaZg9uvYStn1aeHYx+2g1s
	6Kvt7BrqkGGi0R+lT8rKVEvw6tGwKKxkTGsniniCyXtb3AvXnouGEabM4PGcOGdCh2vOC/Db6Id
	I0W3KSk/qVPRgcuAPUGJ9jWPtyVYTJsufgsK6iZCLzzEH6A/8DR9paZrKftWO97qLynau2Ohnfx
	VAl4hqYY1/DoNFV94pRXpTGJ8ifHUu3EzfxMMia
X-Received: by 2002:a17:90b:54cb:b0:39b:51cc:4586 with SMTP id 98e67ed59e1d1-39d9c21bba2mr2583345a91.19.1789092058595;
        Thu, 10 Sep 2026 19:00:58 -0700 (PDT)
Received: from localhost.localdomain (vmi2317697.contaboserver.net. [85.239.239.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfce707sm3587205ad.55.2026.09.10.19.00.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 19:00:58 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH REPOST 4/5] mm/damon/vaddr: extend apply_probes() for hugetlb
Date: Fri, 11 Sep 2026 10:00:36 +0800
Message-ID: <20260911020044.37520-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909140408.104699-5-sj@kernel.org>
References: <20260909140408.104699-1-sj@kernel.org> <20260909140408.104699-5-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 9 Sep 2026 07:04:06 -0700, SJ Park wrote:
> DAMON virtual address space operation set(vaddr) does not support
> hugetlb pages in apply_probes.  Extend it for hugetlb pages.

This looks good to me.  The new callback follows the existing vaddr
hugetlb walk, takes the huge PTE lock, and keeps a folio reference while
the probes inspect it.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>

Thanks,
Lian
