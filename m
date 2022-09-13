Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213877F
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 09:12:28 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id 207so2331300pgc.7
        for <damon@lists.linux.dev>; Tue, 13 Sep 2022 02:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=T1+v0d/bxtpbeCpIjM7V3ktpjxkQkVAXdQmTNVJDAEM=;
        b=phX5QoGvrNy8xpfI2gGMivSlFzgn3B5KbixZo5B8ab4PmEcHRaJI5Xn//4ecpyMkvS
         TDb5xDOb7i8TR/v2wL5OfewuXvO5oZzLiSVmui3RyPBzT/LaG8LOWgD6knLib2JpwciC
         YWznC/Ri0Wg75EEX3UL4/nQ1/H3FH+ey1fVYGwGtr+QH3qwfKs9Q2LTjy3GowQsqVK1X
         pdSeaTID5rLESOBz491DeR4F2B1NwlqfqJhpU0BBQ77N7ST9pr5mpUu3qpHMs+0H+Peo
         eOWN37qPRjeta1YAHD8sywB9ByVvp0V042QT9YtnygbO3GzDX/2sPzU8x7CNJ3SeCHY2
         Eh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=T1+v0d/bxtpbeCpIjM7V3ktpjxkQkVAXdQmTNVJDAEM=;
        b=gsa6+uzIunVttiheiy768OyUFGV/UWVP38VFIUoWJJiWiclsz9dW8BgGYpR+WumS4A
         f6GibYrHvW8S0fpxWQwX5E2dic6Gp144YYHy0zeWmiCN3NeuRVGp64YmV5Dg5m4Rhej5
         wpGgZ7zImFy+O7IQgaz+imswnmfAsliApcEyaoSVB0MLrA3tRG4qpsFi4Yc6q9UBeSbj
         NUp7p6XByh6IMP+BoZPANgMp7gm9NYaJ38/NSdlwALhBohLXTezV32oXNzKePF/WhHKf
         e7vHj1u7NqxxRRZn9a95Np5xq15B7SxIMhIA3zcBp+6zXfKYYkY4nyzLcUUzMgat0tZV
         dong==
X-Gm-Message-State: ACgBeo19yEv70wYPIJK54JU1rYoL6xaYUipJs1MXrWsKU9bIOioH04P4
	GmWC9AALx50svEHagKS/AA==
X-Google-Smtp-Source: AA6agR5vqxeVAERvE5UY3Z9wKqtcjV3CopPOxGu5qgq+1b8ZMvv336BLhUadurdXvgHg2vM52RgT2A==
X-Received: by 2002:aa7:8397:0:b0:535:933b:54c with SMTP id u23-20020aa78397000000b00535933b054cmr31422247pfm.38.1663060347431;
        Tue, 13 Sep 2022 02:12:27 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0015e8d4eb1d5sm7804661plk.31.2022.09.13.02.12.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:12:26 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 0/4] mm/damon: code simplifications and cleanups
Date: Tue, 13 Sep 2022 17:11:23 +0800
Message-Id: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

This patchset contains some code simplifications and cleanups
for DAMON.

Kaixu Xia (4):
  mm/damon: simplify the parameter passing for 'prepare_access_checks'
  mm/damon/sysfs: simplify the variable 'pid' assignment operation
  mm/damon/core: simplify the kdamond stop mechanism by removing 'done'
  mm/damon/vaddr: indicate the target is invalid when 'nr_regions' is
    zero

 mm/damon/core.c  | 24 +++++++++---------------
 mm/damon/paddr.c |  5 ++---
 mm/damon/sysfs.c | 11 ++++-------
 mm/damon/vaddr.c |  9 ++++++---
 4 files changed, 21 insertions(+), 28 deletions(-)

-- 
2.27.0

