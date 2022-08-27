Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D092567
	for <damon@lists.linux.dev>; Sat, 27 Aug 2022 09:03:13 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id c2so3567847plo.3
        for <damon@lists.linux.dev>; Sat, 27 Aug 2022 02:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=90UlM2PuWOh2i930PTJrjm9Hw09uaXewUF8YqD4wyuk=;
        b=UZT7avK2u7Igc1jSHNW5W6BqyyviOvdR6mP6igbn1yln+jQ1siSL5Tb+MV+h8L2lQs
         eeKGY7F8CR4qQ7lLvTIpw1A15s5zRadRVnzrKljONn2veUAseTe/UJqo1edF8dJpWJFY
         e93wzsKQjCal8eiEpln43OnJVl5qVGocCkgf7b4Cs7mdA9wdXQ5UOCLfSzOzeEEuDZnj
         yjclsxdbr5xmH/Ruo5ahQ7gp/ThrMpJo19S038MBFPB66JwymOpqdasZwEAw99oe224+
         +YHkEkPzFKlknen3DPuX5KI/yMTLDDdFn8t6meidzYC3pCkhCQFYLJZ7CKEPsWBR2VSC
         hZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=90UlM2PuWOh2i930PTJrjm9Hw09uaXewUF8YqD4wyuk=;
        b=fbd5/XtEt3R0jLOe2tJzOv3TZx+goxlPEgvxu02ZsKJQBS+FaHA6yyGrxiiHbrmy07
         Kyt1AY80xCI2sq43OpBPFOpVd+CnWgTTGSWeD+yijb362Q76jPtPZu8dJnMk9h8IJQmM
         p1uxntboE4vsM9zTLIiZApSrNWZ8HDfyd6eNOFPzqjC1f3wjtKAHQ/0CKkL/WzoILdSy
         Sf5wXvSrvM8RH7J0i8KDy1freCG91js7F3dtfNuYtYVKK0b4v+YELMXP0xmCCq6qxD+c
         gsO+0x+kPC5xXe5tbekEEZ4QGLNXh864jOcp+G6/B/4uVQYZ1r7lxbKfGIYQPt4yc20h
         +GWA==
X-Gm-Message-State: ACgBeo0dp5YTXHCDhCg9qziMLB3jQdAeFuhC4Utnd0A0vJSXLJw0oJ0r
	QJqOVE9wORvxCmHe/NjXSg==
X-Google-Smtp-Source: AA6agR7jm26RfQlxhDsB8HFVODUjthl94fNCvZuO25VcQRFNig6aVaO0fULlUcZMUh5zB99+JErAJA==
X-Received: by 2002:a17:90b:3142:b0:1fa:f533:3191 with SMTP id ip2-20020a17090b314200b001faf5333191mr8274424pjb.193.1661590993285;
        Sat, 27 Aug 2022 02:03:13 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id s88-20020a17090a69e100b001fb09316a26sm2943332pjj.43.2022.08.27.02.03.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Aug 2022 02:03:12 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2 0/2] mm/damon: Simplify the damon regions access check
Date: Sat, 27 Aug 2022 17:02:49 +0800
Message-Id: <1661590971-20893-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

This patchset simplify the operations when checking the damon
regions accesses.

v2:
 -Update commit messages and fix the 80 characters warning.
 -Add the check when damon target changed.

Kaixu Xia (2):
  mm/damon: simplify the parameter passing for 'check_accesses'
  mm/damon/vaddr: remove comparison between mm and last_mm when checking
    region accesses

 mm/damon/paddr.c |  5 ++---
 mm/damon/vaddr.c | 13 +++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.27.0

