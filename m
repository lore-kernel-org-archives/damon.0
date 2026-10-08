Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D054B26F6
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471666; cv=none; b=duMvmhqc/KNWjoP4IKHuvng3sdeyU+GbvBVbmOuFOdeu4ode/98KCpNI/jk4+/Hqk86qUJkkYWLCAvmhZ/mKFxsdyhR7MIt7Dwx+whx19kr6mKLxvBLzre6ZJTG9CtRH0x/0O1CDKmcQQe2MOFVevu8U6OKBajGxNLSXXiYQ+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471666; c=relaxed/simple;
	bh=WWt/vdBiXuXADp1OQQbq1xYyEJrMqKsI5+hXfutRC8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWo8gjkUpc+mvoW/PnO++Fpc3EbBZDh7sDY/N5ge/VMuM74HfwK1tW5TWHvlAg1DCZ1l+EmC9bK+WfSsouQMVcdkTcqNZ1y4jBEXEvJMSPcHsw8Yz3Isvb5YBA0527JrqtIEO6UYOXug90U7Bal0Ifd2QMVVgj1HQhJ/i6sXLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWLVhNs+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWLVhNs+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E4D1F000FF;
	Thu,  8 Oct 2026 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791471648;
	bh=aswRrxvRLd9s8zPtStkeYzsIwlrO/oVXbFhq2BxeHcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GWLVhNs+5R0A1zVlWzA8DdOF+6uvIgOdLMNDiKNcADdERgRnmqxLD3nU5Z0eamev8
	 SMGsOahpx0r2FU/+fXebfHa321tssU6zn20uVu35aPMoohR5oUYWA+01dhraJrylz8
	 q01Q9IWo+4qrYmOVlOKhDkpOzjiottClwBD68dQn0jcS+Yi0F5h4/1+MgwN5exR60E
	 A5DhTvKlCtUb7ipzqJCBNMLoEwvfCJGqxajVHyEQgXKlJuqDCvnY8VmKaudeZLWkHE
	 sn+CWUFPDOenUer1sacHKYS+ARwmuRlFnGm0RXqByfTvLmSzyDbgl+Yk+rMeA8ak5P
	 XU3YSqmZTiXLQ==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC] mm/damon/damo: saving damon sysfs configuration
Date: Thu,  8 Oct 2026 08:00:43 -0700
Message-ID: <20261008150043.46530-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008134442.31243-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  8 Oct 2026 21:44:19 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Thu, 08 Oct 2026 05:32:31 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Hi Liew,
> > 
> > On Thu,  8 Oct 2026 20:09:05 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > Hi SJ,
> > > 
> > > Just a reminder, I think you might have missed the question I asked.
> > 
> > Could you please clarify what is the question that is not yet answered?
> 
> It seems I forgot to ask the question, my apologies.

No worry!

> 
> I would like to ask: after reviewing the reproduction, do you still
> think this is a real issue?  If so, I will start working on a fix.

I'm not good at reading the diff in your previous reply.  It makes me difficult
to understand what the issue is.  So I tried the commands on my system.

'''
$ sudo ./damo start
$ sudo ./damo args damon > damo_args_damon.json
$ sudo ./damo report damon --json > damo_report_damon.json
$ sudo ./damo stop
$ sudo ./damo start --kdamonds damo_args_damon.json
$ sudo ./damo report damon --json > damo_report_damon_aftr.json
$ diff -u damo_report_damon.json damo_report_damon_aftr.json
--- damo_report_damon.json      2026-10-08 07:56:04.979178016 -0700
+++ damo_report_damon_aftr.json 2026-10-08 07:56:27.717941609 -0700
@@ -1,7 +1,7 @@
 [
     {
         "state": "on",
-        "pid": "46402",
+        "pid": "46449",
         "refresh_ms": 0,
         "contexts": [
             {
'''

And still it is unclear what is the problem.  Could I ask your elaboration?


Thanks,
SJ

[...]
