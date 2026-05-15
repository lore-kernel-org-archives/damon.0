Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4221DE8BE
	for <damon@lists.linux.dev>; Fri, 15 May 2026 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778807935; cv=none; b=rULV3iDb9QuFGfigQib8gJGL2bOiYfcTsufi0mcbl+1KAAq0AAIvZnsfiH4iX7nExp9rFurRw6txlL2exd7zjwY8dJDVjsVfQtSPlTZHRN2sW3BB11Uq4DZhGayWampoFIfx4CCgc7u8wkmE8c8S2iJ/3DtyO/rfWzak79y5HDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778807935; c=relaxed/simple;
	bh=WlIgxv2WOkhd9BA7qgEROukyQZLnqCDxFPXBnBgpkxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cn/5YuS6rSsNz1oq6zm760it4Wp5f2gJLlNC3QlVUY6dIB9/LkSYCj0B6gl49NvE0yOMFJA0/N58UOB1ME4SN6/Pxa4sQxK5w631T8U8VehokHQUvjOpbMtH5gcZtC1zTys7WXFYo+aieo14YoHy1tWCRta3fXo2gFTt1sg5ZRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=E7OZSQaC; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="E7OZSQaC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778807889;
	bh=WlIgxv2WOkhd9BA7qgEROukyQZLnqCDxFPXBnBgpkxk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=E7OZSQaCZ82ptg971hBAahqjlK8pUNsszyziGpr/+lB4YwfFE1ZgRaXGcHerlK20U
	 AmXxpJosUPSBEh4tuIG3huvI9KOMLvI82doXQY4Sc4am8q1HXriK7niTk1li3keHwg
	 pw6tlMQT1FpRSslPSVmhwOPheNESXLDqID6xNpqQ=
X-QQ-mid: esmtpgz11t1778807875tf5d1f439
X-QQ-Originating-IP: 4enGO/YdavgA2rkJqVQxpQ6Y3+iWq8buDIolvawtqy8=
Received: from PEN1097 ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 May 2026 09:17:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17802444263812327698
EX-QQ-RecipientCnt: 7
From: niecheng <niecheng1@uniontech.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	kernel@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	niecheng1@uniontech.com
Subject: Re: [PATCH] mm/damon/core: clarify next_intervals_tune_sis update path
Date: Fri, 15 May 2026 09:17:43 +0800
Message-ID: <60CB7FE07929DFDE+20260515011743.3476164-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260514234510.123948-1-sj@kernel.org>
References: <20260514234510.123948-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: ODmRr9XAsEUIewZAytL2fcXlbW5VEZcrNMx3fazS9SD2LXSNGVPSKwCu
	D+4SrxJ1OTObGfekBvo+kiYqE1D/kTC3o02OOy2J9GwJO1UKEALkWem1e2mnsYq3nf3eXeX
	bwvBuWlAxMIckPICH4SLDq6m1tg6OG4hzoSaRsLbuBSIpUkWUUw3fUpZfpYBk7DceGFTtTt
	VNAx4gRGEx+Ud0meNAl6r/m18FWzt9BE8vbsQ0dOowPpptS2uUk97EGK6XTGGVGb9ZwcTFd
	N8s8u9pCezGmF1yFXT6sSOqizYbNXttCOooMKVq9hB54I0pTEqtbeKmiT8BQCrNp43iYk9x
	dS02AtS4f8lVZZYgE4jjUjqDxUnGynq5PfOc6JNy5APfaF8omlKOILplsa18PcpUhc24d3M
	CuvXOoHqEkU8bgIQCrpObMWMRRGv87vPF2B2KihM++IurIjjxxSPf4N1LlNesRHeOZYkZDB
	0oW7Po4KomXjxGjKP6f5KBgUaudeM/7PeJk0dsASb8YCagx6CH1ScUkz8vjYJL7WLE1QWkW
	wQsxJTV+zg4sGMhmaQPA1Yb1h4VlGU8qvJsypsipmWgGHuIDCe++6CEXK8bIexu7OphlnsT
	f3Ymlfk8QpRsx+xwb8cA6TcewUoUXLvWEBIhQtbIBvQkR0Yvb7lvJPJmJUu3IKWdr/PMTAS
	QO2QvPtWWqkUqbB/gVjtrQaydtTHXB4GEJ2xGdcFXVPWx1jcHyZprFZkiVExGp4hHmC+rKS
	XE6+0HxCqwjRrrA26fcgGTBuruiEXsygaGTbgDP0Am/k7y2lrDVx0wXiqBT76Yqe3C4L922
	+/9/6HXVDSdjhw370Ytqvaf4ya5gdGjZBLx3F67x17uLP356TZ57NC4q+Np+puNCT/u/Awq
	xMsyfOSH0mSvqziLixKYGnaekRiIGFI+dNAw0S4Uy3DbhO/J0oRAq3wL9v0Gs8l6xm2escL
	RbDhVQ2VZsmufUynPUVEg0t5JHEWEhZbOD3mlP0L+yprgAdnte6Lod3JB8GAxCaNVxdh0sE
	84KNKw1XEw/1ak32F1LP10SqDf+ungtAFeV4wCE9zccbRwFXIf
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Hi SJ,

Understood.

I will follow that from the next time.

Thanks,
Niecheng

