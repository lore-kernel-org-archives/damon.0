Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435343;
	b=Gu64dY024K/c89QRmuEia60PSKQzmuXBaMznUImfStYM1SMFp3P/4Lve8IwQcV9Kb9lr
	 ++8kiZ6p4x3dPUk8A0ASO3BcsjiXRQvqY5c9VLs0lN9ybA35NRngF9CSAktz+jZU720BJ
	 SUdxOhIsq+3VXXP/gczn+JdWmJE67A240qVZP6SL/RGVcYRuC2abY6g3sXVYg4OraRFtT
	 D41PpbKEyCzGgQGdVIk8MGKGlec7eb6LyDxIrhmibOu8W7uoqZBorz8v33KaymRLvNMJ7
	 s2noZ4sQQNBh1WzLsY2cjxnhNCJsfqhmwl+GTyj6Gsl/1ldL2KhIpbk/k152LYROyZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AN07mvctlxPGmEspqmzDlAE946Nit6fqjtUvEUULyM0=;
	b=5hpfTnDcLL4gk/WC49kDS2sXULC5Vkys3/1kX5LCtZUNrhDambqHaXTO2hhQYTGGBo+V
	 fT/r5RMqtaqo2eGrkrlCbPKQYdCLa17orOqpt+Hm/0uhfHNt/dmm261AsKmkz2Mtr4i7v
	 DqnAO5VT8RVeYJ88gV1hO2IX3/olNw+Epfe4TBEb4pGVRkaJd6J5vTusscWR24/iGhrJp
	 8RsE93o6e7ItA45tje15eTwDJ9deRadV2sGiZXIbf1TvQDBeTe1HVwQNGed7IsN4E4byO
	 wGRbk/85PZtxI8vuh5eGe597gXNj4YiZfx9bJgWzssaMe4OTaLLzBHfWXfwZ+vkhHcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PAXm4Qbc;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3425B606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 12:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3425B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PAXm4Qbc
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b3ada81853so3565400c88.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 04:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435342; x=1796040142; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AN07mvctlxPGmEspqmzDlAE946Nit6fqjtUvEUULyM0=;
        b=PAXm4QbcLXg3eGRdh/fPnR2zEr+0LNKOjQCF567Y6JRtvLeym/7F+72GknAHhIzmal
         qE2V0+n1Yi3dxSX0rimykNkUIvgFeaYsN9tj3F0eTXV5tkjw1xEV6Fn5OdEc+pa6Cl0w
         Fb1Fyg+GRNyg3WB7XAtSi79AWkThmlRlypyO0IxjKD7YLZ8zqNOXml9zAX+zC2R9I0Sz
         hf6uHhuE2RoeEBRfWnYhsaAMmxX+SbwwwQsY8NBEYCf+9tqbqbH+YT3/6ph9clzHdSu9
         iXOmBLjL7zcOusLNzzEnDx6IQz/P28Sv5/IQE9b5tLT9OauNYjdnsm4+qpo3voo7QHn9
         p8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435342; x=1796040142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AN07mvctlxPGmEspqmzDlAE946Nit6fqjtUvEUULyM0=;
        b=RbGQ37SgclWsJVYkOZK+Fcc+nEc7CATjlSIizaCFH113mb9ia00jayc0wgjsQRlXzQ
         jWGo2xrU9Cv4YBjRoq3s2yR7djP/gysMGnLmZnBDhj7f05rEqKb/UV3IV9InKLK11zwv
         04Z67IQkUJ+U2VI7cysH6UCE/orMazy0dDbsoeKtX6fAn5c8HjpFUDYGx7OYkI+AEWfF
         J7SQwFb40Ppzbqai3H6acNiVJt0j0Tc0hzl7hUG339O+D3Mmbnza0oRGwLWq/TZAjIax
         /zGJsbwG7+KAPK2k2SY50AfjRZy/Ue9VXq5EXAX1JKH9+EYKxoB12Si/mzXX2eLES64e
         J96g==
X-Forwarded-Encrypted: i=1; AL+hErFEauUN0/XZmuJ7BI1OVwR4vcMm2y15jP9XsFFj/xf3UotZ3HcwN+70oBs3EaykH7XBL2Xtqw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Dd7Y58gz0SJiyIfDSeR9liuN12lxHQ7uhHr9/3Mi6wF44Ev82
	ymQ//2Ik3xsSfm5t55pEMQqh32k/23i45uJKQvUP4sFOXdMU1hD24ZSU69/0KzLFGDM=
X-Gm-Gg: AZFdTZeUh51CIOpik+c0gikDkL0p/X4lFVcAg+4SI0/iflFCjlepTPukeDQHKNCIThL
	PwGGf9bBlEM4I+OUexEfeVYWSfPfRM1xi/IkN+qE/UotVk/CgrgNLv2BdYZNtmgJeIYI/rahcrU
	bv3Ln2nORdh/FPQeLfQYKVuUWHIi8PTRjMJseQ7/FEFPzr+OiDTn1yaAaKw2ZG257W0YuSwJPHr
	REUO/g+dlHCpT37tIQGdaw5PuSOylD5dUolSnfLlX8CjvZt5jCN3TN8u+N4IA4jPynZkbjUvScd
	2Fl9J3lF1bo/MBws+fK6V05/PHHEiVlB0ptS66Roh6QaW6355EdFs4kAExvTGQLaBfwLMZkKKI8
	uc7jcEcJgg0apuANZmtDjBE5YRkVcSJffMu9g28+VK1VBtzzINp39EVQ2z5xVc0SzJFRGUBhplv
	nDS5VgKhyOZP4YBZjqYUc8ZeJWgEMdGOfDmSvuXon5E974cempR/aBZimFdp/lgVlxrNRHKMH6W
	Afy3cPdPx2/Frj+OfIdxgpQ+fK4GemGbidCgMZLHUAC8AAZf2AVWVa91uNsCUspQJJ5OEsrHb9h
	QZrEZr/etYUQkW3i2QD1ke7cS93sAE+HItbjfZgkKjA3CiqZ0FfUscB+GgY9eNGgd2PG
X-Received: by 2002:a05:7023:e41:10b0:1b5:43f6:74ee with SMTP id a92af1059eb24-1b5567c1250mr10247759c88.1.1795435342118;
        Mon, 23 Nov 2026 04:02:22 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556829d31sm45356071c88.9.2026.11.23.04.02.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 04:02:21 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 19/27] Docs/ABI/damon: update for REPORT_MADE probe filter
Date: Mon, 23 Nov 2026 20:02:07 +0800
Message-ID: <20261123120214.9330-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-20-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-20-sj@kernel.org>
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

On Sat, 21 Nov 2026 13:00:03 -0800 SJ Park <sj@kernel.org> wrote:

> Update DAMON ABI document for the newly added REPORT_MADE type probe
> filter support.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
