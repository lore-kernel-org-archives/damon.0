Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794981739;
	b=Mi3kFi0QmguSi0KJj4Wgm3PGQVB+cs5SoDZ7Tnxvr2xfdLQkLHOB9tZgqNhabo0uHhCO
	 v0T6tbckEVqNtBf8Rpkx0FB8ylDTEPfKlwweMlJj+XWLAM2OSHssVVZu15UaIV3hTkf5b
	 MIKtkidZ3QI3k3QYBXFGWh+hevByw9JDqVVapPPVc3fDCFWtMhIo9O3yEmla4nROb/pXK
	 U2EEA62mUrVvBpFi4dvalhsvs3m3qhBF/ajpYPxl8VylNEmRMRFCqkU200ROeURcd9+CM
	 Xagu1h8VEprt7rkkLAj6mOZTOK0X5/mU9xCx1xv7rOYjjcj52EC+4Cn8TtazRiKl9ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794981739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LaBm9JAGPw/iEA5LuoUSy3PZbBdZOK0pwal6A+I9F3k=;
	b=iSe/zC6QBAE+A3hZAXF39pxQOkhrTtfu9nToWWJMqGVBE85pvNU0EaJWofof+Fcdy4ro
	 Ur8NERP4EvYxF+PskU3LmmZdPf3AFx/Gj1fgb5RB6lkCxcxuKx9nAtSvwY/q0NbexZqih
	 wl24LfdJ6tWAGLN5c4f7UTBn4sJ2KAZvv0o0bms/RZOZt9o1RSyvx3qodTD/sk9vBdlW6
	 N06FntsJYqrLRjEsY9ZIeGC3cTcsSEJgzIe7UxqNLFr+toDyPrT0+Qs/ji20GFJZbYxAb
	 MMoRL2gOAixPYbR+U4xZ7EMHuGGw0oOXrfMybyg3Be4VHgNjHeji4ZudeysxXFio3kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cBZt0hYj;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C7606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 06:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 248C7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cBZt0hYj
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b1cc08166bso3245c88.3
        for <damon@lists.linux.dev>; Tue, 17 Nov 2026 22:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794981738; x=1795586538; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LaBm9JAGPw/iEA5LuoUSy3PZbBdZOK0pwal6A+I9F3k=;
        b=cBZt0hYjk4l6qT4ZRImQLCyZ9BKK8tpyjmkP+D9O5MtdXy7obD5eqtO5XpU0Xe77Eu
         JhrbS0ptrSrfooGvFIwZ0Od+ZNj9tDR7nuuXTPrHJIO5t5LONJJsWzMxDYJs4YNWnuGJ
         al0yqWlbCmwfQ33pNgz+8TFyIw9i4H2d0n5HsAOKnWTHWhOECV7KOYd3PqxVbOIl1CiZ
         K/nc5mtj+NIKtC5v1I/oGStnojz0gAqE1iBqd9xyRUAIHOOTdhfT0+g8vXiRMj52F0WB
         oDROJ83UcnrTH5L2i9+hlZ28LHWXzLLrJ05vAaOWbduGq3+q9Nj4/7lYjBLA9WjCer6+
         FAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794981738; x=1795586538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LaBm9JAGPw/iEA5LuoUSy3PZbBdZOK0pwal6A+I9F3k=;
        b=GP5Yf9XhSS2uA6Kuy74Wr2OvaLbWIdVUXU4ouP0s4A4WpVUqytfp3/AKbm9f6U4FXf
         J4njZSvbdRYgqp90YU05L4SwHEa/PqpfqiHNv0VqSIqMI8R2urQEJvbbphZod+KxVK5a
         1U5PMgkf5sCFVm6FA9lXJzuxnzvvq8JGh+6TDOUNm38TQWYbuTdBpj2lpmLnxdEhBcfd
         xG1CZLRclt46+Xj+ZbeDnTTIF5GuBO0mLHHr85dw9MGD66XBHloNbxoyz4v7wc1yhG/r
         kvsmVid+HTwGPeI6Sg5xfWT+kq6vOU8GgAP7Aopo6Y6Rj0nnlD8SsN9jiSVK60eK6SLj
         9U7Q==
X-Gm-Message-State: APuU4Z+WhG7W6WnegR39YnCsoMPyCBeOjlLMV4nQMdp1fQx+dqZ35Twm
	ZTzcgnjl21oAheeSAS3zLkOeMBekDFb1AW7PjQoVYpTyPDpJzp71k7Vi
X-Gm-Gg: AYBFou2QphJFW0CsmSiMQvdwTiLdgQyfhmh5fEMsyuHToZrC8CRH72tPzuc4AhC8bDe
	zZx/6hTuQwYWyaFu8L8eutyYkEqc8TF6gCcc0BJ5uGLB3lJFx/swkRtOLxXdIicm5REyZJK0G+s
	bWXkXGN0hPARHO/2Sm25Mt3aOn1Fe4gBXolz3yXGtLRS8S9wKX/Z7HQaoYVs0Tk9iSyV/VwqPzp
	2FH5wEfIkbJB8TWzsWjTSV4uPcjjNBQUmPZ01ijdFvdY7+vT+6KIX7x/JJUe3HENxGqQuQoIATA
	6PrBQu6cMtDlqSdzdVLWPT9f0hYfPLXk6LL2ltwr8eNhsuur9xzayjgVfkoQ9s9nxBF+QT472B9
	7S7ApkJA93A8xaEinGxQl2T8cM+3LdHdsIbUm02mJ1S6DvGmrLzgYdSbWzSy4MzsGxLluppkgZ+
	KFY6ucdXK01TW8443f3sWzvX+hes3mmNBeufsu+WGGwy/WpemvRrJH9muf/iHevEJuwIi6/PnNj
	p3Bs01fPM3wTUy7clj5lXy//W5ZWG8c9TIRGn+I23AgNINBRyOFdFmYxEtHxjyFjN9djSPJWRZB
	7FAoZ6fyTmC5A68yaU/jtDqjqF2YTLckv/v6YPdHqOiVMIUDbEdl
X-Received: by 2002:a05:7022:f202:b0:16b:4f52:a08 with SMTP id a92af1059eb24-1b543a14345mr3293891c88.0.1794981738026;
        Tue, 17 Nov 2026 22:02:18 -0800 (PST)
Received: from localhost.localdomain ([27.59.52.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447f4e19sm5317147c88.13.2026.11.17.22.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:02:17 -0800 (PST)
From: Sailesh-003 <saileshnandanavanam@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Subject: Re: [PATCH 2/2] mm/damon/tests/core-kunit: add test for damon_call() with repeat control
Date: Wed, 18 Nov 2026 11:32:06 +0530
Message-Id: <20261118060206.29439-1-saileshnandanavanam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118014632.95656-1-sj@kernel.org>
References: <20261118014632.95656-1-sj@kernel.org>
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

From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>

On Wed, 18 Nov 2026 SJ Park <sj@kernel.org> wrote:

> I think the above last two expects are somewhat too much implementation detail.
> I don't think we are promising those list status.  I'd prefer dropping those.

Agreed, dropping both list assertions.

> Can anything leak or corrupted if we don't call list_del() here?

No.  The control is stack-allocated and damon_destroy_ctx() does not
touch call_controls, so nothing is leaked or accessed afterwards.  Will
drop the list_del().

> Could we merge the above two tests into one, say, damon_test_call()?

Will merge them into damon_test_call() and send v2 as a single patch.

> Apparently this patch was meant to be sent as a part of a series with another
> patch [1] but individually sent by a setup failure.  As a result, this patch is
> not reviewed by Sashiko.  Could you please repost as the series?

Sorry for the mess.  Since the two tests will be merged, v2 will be a
single patch, so Sashiko will review it.


Thanks,
Sailesh
