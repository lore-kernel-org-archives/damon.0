Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586DB17E
	for <damon@lists.linux.dev>; Wed,  7 Dec 2022 00:22:10 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so5356859pjr.3
        for <damon@lists.linux.dev>; Tue, 06 Dec 2022 16:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z7lC7jlSvTqXo19/2/T5KkOA5f3nGD9WS088sLB+XjE=;
        b=UXS4sbGRHT2e9Ver1b4tiyqfrLxdn6Ag3POCRrJqT382zI7se7rl4hJrM2DsFIkoXV
         yxD0v+yf6FMQ2H/3YaDW1xsoNQ7hnsIBvLVMBX5If6Lrsk4OXCIqFHO7ZrmbXcd005Ip
         jhfM/qhJ+Tlx44J7oBWSmkXyPFf5FpmnYnMgyB+0AAN4F7z8LSGLhAIc2akKouqF2927
         IFP9v43gNWgaKgQgx+NcpaU4xpVzx3G/FuO9ZHyddwtnjBRI438gilUsgvzPX2NeZnm/
         A/NdJNSt4qBU3x32XILuU5yDrA9j6ksOTf1bFDxZaYcHYQ5S76Bvx0zWkYrfnmwrOqH8
         sIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7lC7jlSvTqXo19/2/T5KkOA5f3nGD9WS088sLB+XjE=;
        b=5mx457s+PsUy3SoULZvIck2hHH5RthwnVbfOuKqTmbTHeZDlEI/xGqt8+U6nDNcHnQ
         TgW6rDlOVae/vFiqYvcyZ2do0R/K/9r0vvibHlwIzD4nEIhOA7yWxIke2ejS27oIg56c
         pZEZErqhjuwP4yqpGk8MbN2YsBNebYqIRwveowLFZmRs8v07dp1uIQi01rr7UpughuW9
         xvZtdqWqhUCi1K8Js8KWL6tHCz8Wh4DHQ9RNIudLe1tuihPCdz5LEhhDp8qqEnAgPm8y
         OFJ/PVSqLijldwDz6AXg/Z5p9cPaW8xMAunF0jaCllRky7lySoNDqYMN+WZ1SZWJ+pUg
         0bng==
X-Gm-Message-State: ANoB5pnFUl7nEYDCMW+hN0c4JmLIIDilCfx4XV+oHq7EiwDGB3TFmt65
	SVz0ojKYDrLk8CSZXgYCdEs=
X-Google-Smtp-Source: AA0mqf6z2NFqTV4MCD+CBVSzYVkEfy1O6XiPtDBoUQ0qnPog5yxgEMm9VDGL/OH52IwW/TwcKJ0ygA==
X-Received: by 2002:a17:90a:5d08:b0:218:770c:9a40 with SMTP id s8-20020a17090a5d0800b00218770c9a40mr80245124pji.158.1670372529672;
        Tue, 06 Dec 2022 16:22:09 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id i92-20020a17090a3de500b00218ec4ff0d4sm13369459pjc.6.2022.12.06.16.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 16:22:09 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 0/3] Convert deactivate_page() to deactivate_folio()
Date: Tue,  6 Dec 2022 16:21:55 -0800
Message-Id: <20221207002158.418789-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deactivate_page() has already been converted to use folios. This patch
series modifies the callers of deactivate_page() to use folios as well
so that deactivate_page() can take in a folio instead.

Vishal Moola (Oracle) (3):
  madvise: Convert madvise_cold_or_pageout_pte_range() to use folios
  damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
  swap: Convert deactivate_page() to deactivate_folio()

 include/linux/swap.h |  2 +-
 mm/damon/paddr.c     | 11 ++++--
 mm/madvise.c         | 88 ++++++++++++++++++++++----------------------
 mm/swap.c            | 14 +++----
 4 files changed, 59 insertions(+), 56 deletions(-)

-- 
2.38.1

