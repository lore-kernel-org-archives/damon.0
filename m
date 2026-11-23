Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435004;
	b=JmC6na/VdyUTWl1LFl3+MnR1PgI38rStaKHe+pAGhBSyeRc/OHeseedYgDdTI12XO96K
	 6+2XU+Yw1FlqVzJcVrfNgRPZnuRJVcnKVZoUKrtTiKojqAsxFr2d0zdfwF2zSRdFqayxl
	 q+N0j/x6iwl5I3kwDCQeZA9r5shsrckHahigtx5tTJ31KxIB8LdvqfhVxzyZdi1/nEUHJ
	 rLppZpItEi4zNzTwRNN1HNFQql2zSra66I0aAz1TgGvjPSdpjtX1/kYYTh0bcyfS1AdmS
	 dnPdKmnWblLeIJOcNS/ZKhl6O4QTJdCydKn28ggmUGkk6G6F6DQYYa8S/39izUKWzsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZJlmpMMEeTrTkXIDblm/53j4ojpLz2OHI/cOPPGH9Ko=;
	b=ps0RkeeazXpGArTrRTFlZCGeljwbYNwXVA42m2483AtAXhwwZ1PTz6dD45ZZJdpTL0We
	 uVKBFiFNM+XK2KhELz4bGxkuiWvOcBVXHiGxDJPWGfGI+IyMrfQL9xyM8N60W5uuwGSUq
	 dQ/5Q8WkXthIl9bjJF9blrcwkSiN4iyy4fqF8d5sKMK/mV7MPWychO10S+sTQQTzC8+J4
	 FK6YJtisYMi0OpRFgOA2N0dC4K67ehCKA1TfuaV6q9Oe/kKgJBDPF8icOgwjTIVUJBn/O
	 dQKVJitTfPKcqOoi31msJK/oe9HB3zEPjMcNgpeoLLvdeSYt+Uau51WJ9WW1Dq5t8+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QyoFQtoZ;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FACA606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 11:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FACA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QyoFQtoZ
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-386ab9ab619so2027904eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 03:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435003; x=1796039803; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZJlmpMMEeTrTkXIDblm/53j4ojpLz2OHI/cOPPGH9Ko=;
        b=QyoFQtoZAY7SHqG3Thy0DTa+XppAPfCnsKuXVZ1SGIq/IwuQdB30gQieCW3WZE3rrG
         NgMkHZ3I5RGjqhXVX9LGhWnPBmV1DhQznrG3BxvaUL83LCkNtwuusQFXdjC0E37UlfZ1
         rbhQY0d8pcpRCb/c38Y0P8hdEAAyt1I3lZZWUhuCqws6GucF0g72wDwG0KsUZ6SqPmWb
         QEg5wLxd93bdejVRFtuR/jrTnMnWJTmMkFRe583BZThdC9vIAzSibmMSzGKkdqitgPzI
         UBBum345HMS+/v5js3A9oFWBukq4Mzydgg64u4UDQCHj3vaOZgZfMPExuplWwCtGlzRj
         t3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435003; x=1796039803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZJlmpMMEeTrTkXIDblm/53j4ojpLz2OHI/cOPPGH9Ko=;
        b=iqFxFTbp2LxHXib1rn/nOV/YW+M3mnO0Y5dwPD4uTqkYlcswPA9AozF5rvnsTo0jDQ
         8LaRS7NPAy74oHkSECjm50Yen0LpG9MhadVV1lpm4VBlKmZRxlbwk2xsNjq236rQ5x1I
         xlmQSZ6c1hejNd3gRhElH5fBlam+9/TpHF1TmmDiwdFWFuJXjUQit7N4oBOsnmFK89+J
         oKILrXdYoYVwKW6VieG4e42X4j+14WDuIQB/6bCOf7addMw3y7THvwCvcVDu5fkHwOXA
         WlnRKBEAVLKwJxaj2mkYyE8oL4yOZrBt2wWLhKEyabigMEmO6QK8RXqJWKdQeGTdqU1V
         pClA==
X-Forwarded-Encrypted: i=1; AL+hErFc1MzeaRvSS+ggLQaMNbMcJ8UILyxXCAYvOE3B5wHpha89EBX4+olqDkoaN/SgqirphWDcqA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+sm84k3LoHeXW7jsgujhVg9/hurILWbdViOF2af9lqLsZ6xEWd
	yN+4iXuAnBUuHzVwXNYYdLVAw7cVNvPLoHinoKNuh7IPoMa93+BpKGfO5IRrb1t9tOs=
X-Gm-Gg: AZFdTZedc1XfsruK1XBiTxZf7f2sfeaxjsClFK/nuE8MNHF9pWBj8eoGfKGrxQtr2GT
	cFauxMLMIQk9cnaJ0t3LV6a66e6lHAOrCRzofaf6PeZUnm2yB82B2tkoyTUXgjK2aSn/YdLtz7C
	keLsIgrC845i13w1NzgElGFDOBxe++f4JhmYNGmhU/4IleF5yQYfF0L6MKOu6JE0RjeKQFPaD5d
	la4W2qZGtUPp15qVrjSP0oXch6vf19a1G0lhauI6zeKaWKBi4OVRxEBb3Ks6C0sIDp9zoSMOybF
	NJZbMbDE30EP7J9oGqn+IQf2kJTSgqA7KXFSSAaBEDCFiN/s839y02HpsiEGsHk3PGmfvuMXXbf
	Hcl6yKMNOoj5x4gQ3Q3GDUnqNXkc6tnpgUffP4KmTUzBJ1BRqVcnbdE2ExdZziBQZAgmj38M6ox
	uMM8dwnVb8+OoF6E/q1uU5OKODgsRxnEDEVwxaxbU91A7vZ0G63iJNIrzRvhy9sV1Xf9OZ6F+sV
	EJ1Po1NHly1OLWWo8GLk/KFL9tV31i1t0paVMb8aSmFQZrI6WbFwNb5ONWiGB/DxNok79WE+4ZY
	UpWQim3p7voOe/Em49A0Lqn7oxOcrtzolsezqvApptYJNq061QEfwzjtuqMJWa/u5FSuJCj5qXM
	NVvwqYY/M/abwCA==
X-Received: by 2002:a05:7301:5093:b0:36a:31b2:8643 with SMTP id 5a478bee46e88-386992b3f3bmr8479130eec.38.1795435003131;
        Mon, 23 Nov 2026 03:56:43 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm33541924eec.16.2026.11.23.03.56.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 03:56:42 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 09/27] Docs/mm/damon/design: update for report system
Date: Mon, 23 Nov 2026 19:56:25 +0800
Message-ID: <20261123115632.8842-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-10-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-10-sj@kernel.org>
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

On Sat, 21 Nov 2026 12:59:53 -0800 SJ Park <sj@kernel.org> wrote:

> Update DAMON design for the data attribute report system.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
