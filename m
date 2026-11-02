Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633338;
	b=I9Vc2uMg3myHpVIfi2dBMttfI9CE7qKf2jipYzl06J9XnOZX1Zx70UyVDfToOPuIZ1qI
	 MDcUpmiv9RS1/9E/fWntyuxiuzsWOQnlVnz+tDaJictgHu0+vmEt2SPMGRdLzyxhJbH8E
	 C8Ts3cWWj/VQlsupOSMK8LW6SHTrTMqVAWF3HuvgGKaM3uwe7Tcfe3pStSOJTATwUyzxz
	 HM0CNdpsJ50jd6QoRZTnVmZdvhLjHBg8kGXvocqZOCqXM2oZbX+c7UJankx+HF6EEpuVI
	 oAKnlp3PSBVs85lx3D/0wJhjxNLl+B11VrKb2kz/NapjmdZS8QQ9wankGB62Rb8FTYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633338;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vgW6iwfR4oxej1sYSTg0bSps9+FkII3Zqymh4t6eG2I=;
	b=ItFR/kDvGPb+eHBEJDetbUsMEIA/r/ZL/w+SCoExa08ZQ3dpEMto+lmTYqCHSeomqdmm
	 H+BDt/w4kFPL/HD1PbwLH7CxQLuai9MFFjXCOJhI9Dj+x0C6y81gdxf3q4xU7Muml92xu
	 DziVddMApsOTB++/HgD0AcNSjmRQ+ZXktIjn2cJDA7hpzdUIhYnBEWtr5hptSc5m7vNnY
	 RRjshavcb/CYNjrE4g0WwgNy+otfh9cnapgC1Vlx271rqRE6gwNP5njdKTeXEaufVGbxJ
	 q/JTAXMDm29FyRwlGVOgVdpp7JljT6h5l1T7uoUz61z8Jv7Nd2f+TFWSXrueqoAZEaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvpLyEv1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E30609D12D;
	Mon,  2 Nov 2026 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvpLyEv1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BF61F00A17;
	Mon,  2 Nov 2026 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633338;
	bh=vgW6iwfR4oxej1sYSTg0bSps9+FkII3Zqymh4t6eG2I=;
	h=From:To:Cc:Subject:Date;
	b=gvpLyEv1W1KJxo1PAJDh8KPS32YJFHX7/HsmuuZht4rmXQ1GtOc6nGzDPSSy5NnCf
	 LMx0sQVe1Yt1Us1YPjKRcAxNNDHs6AtycyfPlTz7kKK+XCJH0WhLzjqPvkq8YIAiKs
	 wDkwg/aum3jc9pA3ldSeevn0LfCRUQEuWAlK6bo5HTM3+IjQ/7HKUEKIkyBNn6GSbZ
	 ecp+8bNQtdUoAzfhCV5mjdmWHn9ghCd93h6BXd0O36MA8uWkvWWwzHiGUkTxHoIjKp
	 5VA+3lP+TzWTeECyXAFF8Dr4pJxXV5bmsXd4jdkxNOb/jrrD+YeQ024oW8ht+4dBMd
	 uLmqwT6KhOzNA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/3] Docs/admin-guide/mm/damon: minor fixes
Date: Mon,  2 Nov 2026 07:28:44 -0800
Message-ID: <20261102152849.96057-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

Docs/admin-guide/mm/damon: minor fixes

This small patch series fixes various typos, copy-paste mistakes, and an
incorrect command syntax in the DAMON documentation files.

Changes from v1
- v1: https://lore.kernel.org/20261006061549.627-1-adrianhuang0701@gmail.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.

Adrian Huang (Lenovo) (3):
  Docs/admin-guide/mm/damon: fix various typos
  Docs/admin-guide/mm/damon/lru_sort: fix copy-paste mistakes
  Docs/admin-guide/mm/damon/usage: fix incorrect option syntax in perf
    example

 Documentation/admin-guide/mm/damon/lru_sort.rst | 6 +++---
 Documentation/admin-guide/mm/damon/reclaim.rst  | 4 ++--
 Documentation/admin-guide/mm/damon/start.rst    | 6 +++---
 Documentation/admin-guide/mm/damon/stat.rst     | 2 +-
 Documentation/admin-guide/mm/damon/usage.rst    | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)


base-commit: 7fa9b9f1350aa38c32315a6de022c770e78dbfae
-- 
2.47.3
