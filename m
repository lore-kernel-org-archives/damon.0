Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795367896;
	b=dFB7FFi+nuqMFlnOM7WXwszy618QVp2TG/pm9gerWAaLzVFvp8r9nO990LZRpSMGxUs1
	 ybH0XzeeZiD1GKDIhunzUvv+/1K3uhzcWGKIwvplOHsm2L1m1LjyAmi9r/Hvi1PqYtUD4
	 l3vz6p2jiXo5Xfzom+W0WXKCe4YToqkEfNwtk+Vz/7TwJNDYURz/okZKHPp9MNW9Lwk34
	 Q/xDchOVjgglWR7YT1z8GFphN+d7Z2xjOD1z+5IxNei3Ml5kJcwOuWPJFbw2f4sN30bt/
	 gAMVj2g1JR8m4MqJeLGauia2WoCmdJ2YmYRmG/iTctE5L6DIkdxMWlGfr8aSDH8UhMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367896;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VGKXMuVis8cRkv30mPNpaMsvVpQQKLnxJm/yA1Jm/ug=;
	b=mCx6jixSrCIkAX5ZvTnPIiBq4ORKpEHuuUy5POugawdvhlFCQ3zQZj+2P9O9/02dRMRw
	 JMuAl7hT5jY3XnVQscJyIRDGLC3Z1+FfxKYSTqt+H/YRQDJkHw4PTEZjW0fmJl4DlJrh8
	 Cw3sV08c9bRadT+yHhQ62JOwGZXOCEOhLv7Ije5ABt4ynqUQUcfkML6BPDwMAKQmf/+Ra
	 GkpPd0urFO7hP7uzO+vxqSZpFoZAZCW0Sj/jpBzZ90xSn7i6fSzthg6M5ltU70TSDyWPj
	 TMj4guOt4evZ7nQYoaQWvpaYryghl4BVix2LoqKv4Kk2zMFBxeUS+IrOgD71vd2jAXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2LgC6w4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8119606A320
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2LgC6w4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E70F1F000C0;
	Sun, 22 Nov 2026 17:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795367895;
	bh=VGKXMuVis8cRkv30mPNpaMsvVpQQKLnxJm/yA1Jm/ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D2LgC6w4Xvsf4tl+B+40npG6+OEBFuxljDzDaDc1prmdZzy+B73Qgnfunp63Keygb
	 bh1wML9GzZ/keUz1upu48d5oFFJC/rYhp+0SMgCReNG32SnsoTOmTK/KgWGz+kkqkY
	 mLu0z0G0APRAatjPV1Wjz//C2VdLfdobznkV2hj+atE5eqjLj7bV8en+4pZ4hsAZI3
	 RlIHMuUMqL4hZ8VE8CxsGMac7POfwEig1xsvQUndMHolMOayBghcrmAbZHFtkcd0Vf
	 R1h45OYw6Uesbp4vmo150hH5ZI3ilnSbobG1SeGb/NA7Znnxxt21d8gFAS7IqGmnFf
	 wzuT9jDXtHeWQ==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 13/27] mm/damon/core: introduce damon_report_exist()
Date: Sun, 22 Nov 2026 09:18:08 -0800
Message-ID: <20261122171809.153322-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261122131652.72647-1-lianux.mm@gmail.com>
References: 
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

On Sun, 22 Nov 2026 21:16:23 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> Hi SJ,
> 
> On Sat, 21 Nov 2026 12:59:57 -0800 SJ Park <sj@kernel.org> wrote:
> 
> > +		if (time_before(report->jiffies, jiffies_old))
> > +			break;
> 
> damon_submit_report() sets the timestamp before taking queue->lock.
> If A is preempted after that assignment, B can enqueue a newer report
> first, then A resumes and enqueues its older report.  Both submissions
> succeed, but this early break can miss B when A is expired and B still
> matches the requested time, type and address range.
> 
> Could we set the timestamp after successfully acquiring queue->lock,
> so that timestamp order follows enqueue order?

Aveline raised a same question:
https://lore.kernel.org/20261122131652.72647-1-lianux.mm@gmail.com

Let's continue discussion on the thread.


Thanks,
SJ

[...]
