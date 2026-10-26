Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013385;
	b=ab3j2FsAFqTE1J4sNN6wG3MWJfzc4kvB6ylYCux3w3QsVxp/WSXDYIYYC0Pz/pyTW++I
	 C+Eu/Fz00Vs2nZb0itS2Ou4DkhfKUJwMIbF9CC1eD79neYT2IJj+HiqHetlQpt8fWY6g1
	 Y42ZG9gn05c+vUmM4PgEEPBB2kVL0K0Ct8Ztz1DsjOH1B3JYQcMBeBRNw854fM8SgUHRh
	 9Nyk1LCVd0TPLB9LuJTxoPpZMWyH/KpiNQRYw96XC6Eud/gDTgzRz8E4QQGayszkFwAC+
	 7wLugqNM/NOYBKLtYaQpCPRv6HVXHJYeCn9LLKTrjH5JamPWbizu1RdW7I1Bfc0O9xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=8rYpsphUHQN5o3M8ULTGHPBVlkOicoYy0qDzZu7+FCs=;
	b=5BzXfP1wiby0yXqjwuMj42onJUFNeSHVLgP1DE5kvHPbOuRKovZFkeB5XEOde2eR7S4r
	 CL88Uxl0sjJsI39z2QlcL+Mt95iMDabADGeqUPMrrll5N/jatb2YlzAsYdvUUwdtnUXcL
	 6S0JtrG9YA3syyxZo9a3oX7f+i3m5QbbC7hwYMtgwdKtC8t7dPo3JK47QUtI/f+BwBZf5
	 n+0nI6zMHe4koEUbP8j8r1lPqxwMuKmD1ovMgzlOtx775BOw5Rhz0UO7UcQB4AY893SoZ
	 y5wGBdwa0367rLJR3CzsTSJCUSl++6UK38jyrtZw45g/klL+/39+uEgqBmffv6TavgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kc8nJlI4;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308A5606A90D
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 308A5606A90D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kc8nJlI4
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac63aee1ecso508662a91.0
        for <damon@lists.linux.dev>; Mon, 26 Oct 2026 04:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013384; x=1793618184; darn=lists.linux.dev;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8rYpsphUHQN5o3M8ULTGHPBVlkOicoYy0qDzZu7+FCs=;
        b=Kc8nJlI47LndOscth+C2swB5WXZMG7n4nOXCXFffUbOK0PiphN+S3Q/MnzE1fAi63D
         je/d+2cNDWnKy6gR04JJjUU6B2/1PxnSG4ILgPkNA60dnhWMm4mdSPrPXOGttbt7d1rU
         XiiCj71h2RYKT6FhgW1j+gT1foZy6UPUg/Q7/Dmatv9+o3RNc0HzRuk5FoELYZdw3HVK
         vvmmTghI1M5GtzICUw4F+s2G7kUrDRd10dZ2PFQyoxa+ckA+aQJxNzNO+/UVDALapoe7
         xewiQo0A/3asowT1CT+WszeQ2aCjHDUzeFBTBPsUH2ybYrQGOZ/ZU/CmUxOEvGFJfeWk
         VdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013384; x=1793618184;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8rYpsphUHQN5o3M8ULTGHPBVlkOicoYy0qDzZu7+FCs=;
        b=kCG0Mdn66q3BjgFxWOluwUWDRxCcPs+mKkikEV4BzL1PJeaPzKaLf2Z9biJF7z5lUE
         y0aqRW98E1/NRGGnue+UwiBRpcnRVTC3PPWtg1No7usYJaiKpF43WGYqSVsVoHm2qmvc
         0LDW6L1lzKDC9ToS859eogLEan5SO3RJcKhzVLuXLKFSDtkXXVRATYjX8eaGTxLMZCNV
         aLlFV6VX3Z2YYVVpWbkZk95U2jbwHoW4RxqlxnR/ysXne+KBGCv/haZ0RBc9VfJ9hVa9
         q1+TwilNazmMWe9gQe50bW1senSp4okM8Wj81AtuOw5U4oZfCwL/rdoOFu1sNWUM5TDr
         IfHA==
X-Forwarded-Encrypted: i=1; AKwUvBzXaMKsEeA7P6LRnI2Lln3B3f3HcNevWGHAq7hROGRfMfGak/LLubXfNI4bBLIxxTmbLJ1zwQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLieyHLn/rYg0fVmn76z/1AFlVzEG3ddj3vDtuumLWcK3CUUEyN
	qmyR2LO9xQN1jvQNX/eeYunG0mPjZKa+LNpVByq+UmMYzBzMsQF4lHJ2
X-Gm-Gg: AYBFou1BKGzt3UuFy8Dysx/npyfNfmBT8zITdmb/ksFzssw79N0ves0HTgdqIeQzpAt
	5Q/tSDVKU35lXncVDEQkk3PL/5zr7ea9SEi2GHTvm+01yYBucPEkLQfAHKyWappq3nsTiIgRRX4
	AUi15UsMUC+5tWHllnWIDqsW9BCAttFoBmVUqgC0ky9DNi1MQQeWTCvgO0GL5GsgCnOrwuONX87
	nah0d8vuW788CmaeW5Ko4ym6i5KYA53EPRo4Z5khzgDzs2BQ/+qv4hz6qBuNF5Uu+7GoRPkWAi6
	RHwau6dSTtxXdc/O2DT95cZ11C6vQcLWGnURhYciBBA7JIPU8a0Ke3yVSksPsfwt/aMCMaWL2nk
	vFcLQU0qcBVP2tXmTTeNJl3daMfpwx/TQaV5LrsPZyVOzNjZd9DwbPCOAy0KjT+zSKjpzj3vxHp
	bBiki4JZ0/J3EVwXjLwpROK5C+XPBHDlDZKDzrOosNUhZzmRKjwg8avbFeky7RBw6rfiadd/9lr
	CpFz8z8sgHMXEd/A2yC/ioPeelG1MPQSHa0pf1mScghz4hqdtduZvfgnqZRmagl4wRbThHVEOTe
	NWeacH0T3CtNi9dabk/iXlAi319O+5M5rSeW5PPqllsZOfWth/XgJQ==
X-Received: by 2002:a17:90a:b896:b0:3ab:b39f:41c8 with SMTP id 98e67ed59e1d1-3adead4dce8mr3439038a91.46.1793013384321;
        Mon, 26 Oct 2026 04:16:24 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc90d74sm1382169a12.20.2026.10.26.04.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:16:24 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Manuel Ebner <manuelebnerli@mailbox.org>,
 damon@lists.linux.dev,
 linux-mm@kvack.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Docs: damon: fix grammar and typos
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Mon, 26 Oct 2026 22:14:32 +1100
Message-ID: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>

I was reading the DAMON docs and kept running into small grammar
mistakes and typos, so here is a series that tries to clean them up.
There is one patch per document, and nothing beyond grammar was
changed :)

Some fixes pushed lines over 80 columns, so those paragraphs are
rewrapped.  Patch 4 picks up what I think was left in lru_sort.rst
after Manuel's recent fix.

Based on damon/next at 9d301805e3f6.

Thanks,
Aveline Noir

Aveline Noir (8):
  Docs/admin-guide/mm/damon/start: fix grammar
  Docs/admin-guide/mm/damon/stat: fix pronoun agreement
  Docs/admin-guide/mm/damon/usage: fix grammar
  Docs/admin-guide/mm/damon/lru_sort: fix remaining grammar
  Docs/mm/damon/design: fix grammar and typos
  Docs/mm/damon/api: fix verb form
  Docs/mm/damon/maintainer-profile: fix subject-verb agreement
  Docs/mm/damon/monitoring_intervals_tuning_example: fix grammar and typos

 .../admin-guide/mm/damon/lru_sort.rst         |  45 ++++----
 Documentation/admin-guide/mm/damon/start.rst  |  10 +-
 Documentation/admin-guide/mm/damon/stat.rst   |   8 +-
 Documentation/admin-guide/mm/damon/usage.rst  |  31 ++---
 Documentation/mm/damon/api.rst                |   2 +-
 Documentation/mm/damon/design.rst             | 108 +++++++++---------
 Documentation/mm/damon/maintainer-profile.rst |   2 +-
 .../monitoring_intervals_tuning_example.rst   |  28 ++---
 8 files changed, 118 insertions(+), 116 deletions(-)
