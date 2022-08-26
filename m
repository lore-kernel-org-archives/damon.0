Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0402A1FA0
	for <damon@lists.linux.dev>; Fri, 26 Aug 2022 08:31:55 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id o4so973055pjp.4
        for <damon@lists.linux.dev>; Fri, 26 Aug 2022 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=6OTlaK8jvc2a8Mce9GUIiufxZRP37gVYjvKib4eNVxI=;
        b=hu0xwVA3obcoMaXIdaCXL3WuaK+vHfptE0/XUZCvwHUKyRVqV7uAFx66Ex2YWq23bs
         uqLdkUF2y2y2+oWziYPtajogn/0dqd1hA85HWOfmlXTDxQQk/e87+DOLD6i4mJETQTw5
         feYzdK/81DlaR/VKs3UoveURZLSctj/mLNSi0bzQn+s52zZhGEVYgpY8/lhXYw51sgno
         SsZYHky0FjQ2noG9m6UL+N2Dnz2xE5NtvactqV0NBQ2Hbj0lGYmKzutys3FcU9gZgJhB
         R6dwcPo45zEOlZJe03K9XYXFACwzVHouCqgi44LWUYCe54nYx2LDIeiBXHt+AgVAH03z
         mhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6OTlaK8jvc2a8Mce9GUIiufxZRP37gVYjvKib4eNVxI=;
        b=4T26aogGYew7IupBx+pyAOKa45ToBTnSoqVs/umus2LL3Ef9DsQvfPAla6CAyxX5l8
         jFUrsqvRalmZHo8Kl3eSOdQvb0Xm4Rznql+GJmPL+GbQEMnQ5zdpy10x/QIFBSAZNzs9
         O+q5I0jkIG6K28LUMNtza+eNB9rrfw7TWiH2IDRyntUkRwSRwDtnXuNMkcT/pNDNHYFY
         +ESJGxd+SPENijZofW/S4ra9dmgCYE+QBy/vORQyUq10rbhreyx7BDxJsyRa2FgdD1E8
         q7cee+jrQBwxDCD+2Ed74IpMDevb7bK2N4BYc3wox/btfEGH5jxaQ2I2Ut2AD+ffAFTS
         K0ag==
X-Gm-Message-State: ACgBeo2dCy51RPid8jdL2P9sNLbaqQTcGRbv8e/WF43QeMHjldXtgEZU
	9dz4GHBkDuLcWIgacdwglQ==
X-Google-Smtp-Source: AA6agR65uXXkQHQfsSMG2BCqAs3P8T2HjY6ak7TB54hxzr6sZ5XoqToo01tYb1dnKDtQBxDtcUFMGw==
X-Received: by 2002:a17:903:247:b0:16c:5017:9ad4 with SMTP id j7-20020a170903024700b0016c50179ad4mr2788810plh.115.1661502715389;
        Fri, 26 Aug 2022 01:31:55 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b0016f1ef2cd44sm934953plm.154.2022.08.26.01.31.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2022 01:31:54 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 0/2] Simplify the damon regions access check
Date: Fri, 26 Aug 2022 16:31:16 +0800
Message-Id: <1661502678-19336-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

This patchset simplify the operations when checking the damon
regions accesses.

Kaixu Xia (2):
  mm/damon: simplify the parameter passing for 'check_accesses'
  mm/damon/vaddr: remove comparison between mm and last_mm when checking
    region accesses

 mm/damon/paddr.c |  5 ++---
 mm/damon/vaddr.c | 11 ++++-------
 2 files changed, 6 insertions(+), 10 deletions(-)

-- 
2.27.0

