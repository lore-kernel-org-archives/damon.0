Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BAE345EA2
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 03:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024776; cv=none; b=Y8wAKs5/8gUwhyLggAwuRWsrPm+b2MdaBGjGJlDqqITNbZKa6/EZbVMeOiEHIwWmOv0wLlOABQrHLIf8xCJR45sFIVHBByQfQKYhIqDSXepBOgLDsbrJBXNTE+AmI7av1xK2d5TdUP9oFy3jgjONYh+1KhA/Ypog1qS7zBGGBS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024776; c=relaxed/simple;
	bh=7ZwgqFUNETnK+eZE15fyxl3BEsjCo+V/zaHorlicCdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtZej652kUIpMEpHaSSxKInDbHJg0dp6xAufVeHNy7pPPW2b4KUCHN1GyqUUeYbFQ9GxDEF0ZeBsiZeWZYiCLwuBMGrmJypf50yXwI1YR8R6qNrPTfQxuqEkC1seHRLfAHxFv+45UpCyDCTDGQnY+xN0UhC357NxFp+82ZmKsFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucla.edu; spf=pass smtp.mailfrom=g.ucla.edu; dkim=pass (2048-bit key) header.d=g-ucla-edu.20251104.gappssmtp.com header.i=@g-ucla-edu.20251104.gappssmtp.com header.b=JZ3FyVnZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=g-ucla-edu.20251104.gappssmtp.com header.i=@g-ucla-edu.20251104.gappssmtp.com header.b="JZ3FyVnZ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso3443045b3a.2
        for <damon@lists.linux.dev>; Mon, 17 Aug 2026 20:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ucla-edu.20251104.gappssmtp.com; s=20251104; t=1787024774; x=1787629574; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvzXK3W/uIG2TnGSiCAj0G4qvHFz9goxNEqSwA5mwyo=;
        b=JZ3FyVnZ5zhy+4vCCXGVfoER15TGPJU+sS8JdRvYpgbDX2bAXc8azwT2zzADASHa9e
         q44qzHgetVCmscF72QxVuAfRu41l2m+s/N+k4Sfzrq41Kus3C+TRMPmv8rlfFXmNfpWv
         bcsCg+LIQDBd3ip75caBHFxp6TEdoEkLvICIkxzZiggSc7VqwALe6A6veybLyqOFDi/b
         gVEGk3YjThc6siyiNoQAfKEMjmOKI3JRntoJsi7vZzMTFpBayuMEY0DEHk/TA6YYwCSk
         dB7yFZHd/9v6X/8yXxf92zuEOTU46xGp9G4v2akFwG0K+/r7BYsdYzg8ib3QPOnV/c3W
         0J0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787024774; x=1787629574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvzXK3W/uIG2TnGSiCAj0G4qvHFz9goxNEqSwA5mwyo=;
        b=ZbaYs2dyi3SP3/WzowsRsHQN2/EAC5L1bj5oI1i/njqlEQPH3hxK6eaj5gNbQSk3jA
         261lqdmFA4i1lPh7/SnFfS43sE3z70CIttimrTBiTZ9DAa2dui8Qmz8NNrPU/pQtUqSM
         lmYM6dVIR8uDptX6cXHn0C8ZX1R7yQM2QXDnBm07rwCFG0u8De5mqTThug3gg8ZP2sMl
         H4Lz+TvnO2bZajvYPXeSA1JsH6tOdNMAuzQQRpKcSAfxwihoH2ERNT1nrTDhVxRKwM19
         Ff+ydD+gsFQWVBCCBLfYZLvzDvMqjIKrA8ZudenU1GdybzItV73krwhbF9otuN2nw9O/
         WGdA==
X-Forwarded-Encrypted: i=1; AHgh+RqgPYY6uLjgQ3T09vkt0HK40MkzQSX2XkdYjByKXQyEof7QX5Mkc3QBAnE327xfW0+Q39oTWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxF49+pBccOM2xfhbL+kxCi+oNKheukW4mhN/BGbxPiMFpsG3Tl
	/zemfgeCNTBaybGGiuqiN/rw7MQhQrEMU6LesQ5ObyJQtxk8eInu8tm53HI5d2FqFo0=
X-Gm-Gg: AR+sD10lr5mU3GrQBIJ0LQigbV7WDi+uH82jPChHJDuQMTPuvKewDsFivK6gU6JQ6cD
	tNTeZ8chJT2sXweUCytN93LKdGkMoAwwES8OU/h6XyY5AzzsHfjGAOwWZC1J4xq4pK3HQyW6/qX
	SDdRQ7Hs+i5fDAf24sukmVGEFBvpsZU2WBGMPyojODeIre7MfEscgxjiUb7muMzizJa6wfawEfp
	Fc6pg7A/Kf97OkRJCz5gABDzpyUlm6j5FDk8L5kdNH8wF4yS7kMTyfGHw1PKs4JgZxZeRun+HnU
	zHAdAAeECzSZ2HhtLkHZE6i40ST3lClgglBBW8YK6g7cytp7XnlHd+o8BSkXJPBGlS5C3CipY6n
	D+NMhiScpzBkZAtND1r8grxJ3M/hsc00+J+TtyJZpa41yIEFVyu8kG/EVaal2RM6Li+WGpRI+H4
	LOATqsjudBJfBs8g8zXpLj+tAxjNiFJm6gXAN/hvWEsEHEItqsiXh9kNqV6kqsixNAiLsIdO/EY
	Pi86bRHHB+vrDt7
X-Received: by 2002:a05:6a20:6a1f:b0:3c0:b943:f984 with SMTP id adf61e73a8af0-3ccda405866mr5334939637.3.1787024774083;
        Mon, 17 Aug 2026 20:46:14 -0700 (PDT)
Received: from damon-kunit-dev.tailb106f5.ts.net ([73.93.135.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267be8e35bsm11453293eec.14.2026.08.17.20.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 20:46:13 -0700 (PDT)
From: Jason Angelov <jasonangelov@ucla.edu>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: shu17az@gmail.com,
	jiayuan.chen@shopee.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jason Angelov <jasonangelov@ucla.edu>
Subject: [PATCH 0/2] mm/damon: add kunit tests for probe_hits handling and probe params validation
Date: Tue, 18 Aug 2026 03:45:50 +0000
Message-ID: <20260818034552.11975-1-jasonangelov@ucla.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON recently introduced probes and probe weights. Add kunit tests
for the propagation of probe_hits at region split and merge, and the
rejection of invalid probe parameters by damon_valid_probe_params().

Jason Angelov (2):
  mm/damon/core-kunit: test probe_hits handling at region split and
    merge
  mm/damon/core-kunit: test damon_valid_probe_params()

 mm/damon/tests/core-kunit.h | 64 +++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)


base-commit: 4b65683fd25fe596b5b5947d934bb176413d077b
-- 
2.43.0

