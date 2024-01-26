Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E021A0F
	for <damon@lists.linux.dev>; Fri, 26 Jan 2024 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252235; cv=none; b=cOZROzHCcdjVmIUicX5FZXTvyGsGHiq6hkeuU94/KoyFFTMk6QVVLTPFaybF9hLOS7ErBWau8V+C8NH45IkFUcBO0dQVmMzni/HuGlEq95wLX3CdN92nyg0VRfA+CDw/X1Z1odY/vxruj205hMgc/Goy8OEAxECeBAOOSS4jBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252235; c=relaxed/simple;
	bh=fmeJgmo1eTm45ia0BY+No10zL89lzqsqyA/OXLp4CYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1ny9JO5BO8ZzX+tHVuIqKn92OfjLZhIFCahfk4Vz9Q07n6fIJ+cm2VH1/e3Gvtha8oVmNaemNzjoqp77qqIHVLjj0dppP5Kaa304V3vM247COA/IYmQlRBbeawZdBFnlbo/1Scp45HRsfOeqsDWmS6lQbMFuV9fpJDwnMA73Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7Qr0FGT; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7Qr0FGT"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ddc0c02665so89781b3a.0
        for <damon@lists.linux.dev>; Thu, 25 Jan 2024 22:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706252233; x=1706857033; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obmNILo/IhMsOn7tNaJgOnb5hD2rgV9SrDPKtcBkAB0=;
        b=B7Qr0FGTZyXazjCVrJlju/O0tbua+YQE0nMCSoCF/Ve21R673M5voWtR1aA58q3EtK
         MQjS42beKR7gkrciiHcQkgqH2EaY3wALLEuM/FYUPGRGHhjczr5eXFZQgpiqIPfWzmck
         R0vislAS8drwFxCOUiChrsMvpSslJ707wjJJvmYa1ml3j7OZBeC8vfyRVAJ7oF+oBe15
         +BApSvaty60yqigekz5cVV2UyQzi3FDgVvk5N5euiTws12Y8sLY8yeciOUUpmnyvoAVv
         V9rpiTP+jkhT/jcn2iEGSk4nUztwe0g0YycXaULitUt2kdVrmA7xCdQahrGULpw72gxR
         RRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706252233; x=1706857033;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obmNILo/IhMsOn7tNaJgOnb5hD2rgV9SrDPKtcBkAB0=;
        b=XKQ3UR+y2HTHJDS6ZiqNPpJAq8Afaeoyy7lPuDU3YLTwfa+KIS1acclC2OGswbWUxK
         p0Oz1a6J9eKB+miVMWPoPXfzOgukxhusrDfrit4knG/quwnweg/XDuNTSyjqkXSzcKSu
         hmkIejn5297U8MtiuOrEA4nT90dvGURiSQ9jSac3LsTcA1456jgYvmfV7IqAtXwGy8Vn
         etnEswwM4PK0t5P+BTsjOxpcQdo0Z7vX05HCARYMJiI7rDXHlR8VTOMuaXQ/T5PTy5Su
         9rdO8ozfBS8Ig4WyUk6SQTvQ8GMkeP4Sebfn4uHvDEekfHYP0FCK16MgeD027ShzqlDy
         7T8g==
X-Gm-Message-State: AOJu0YzNyLGhhOcC9wVEUMl0YEEWf8j8fKviMWBzvQfIgfYvbSLPwIXz
	wptWOR8LE5r3Mgs2eH5DcOaMLRSts0HsNQcRw7/k4HNncsT/bm2wfv28MDvX
X-Google-Smtp-Source: AGHT+IG7PKlIuVbF4dQed4/SZvmdfB0JA0BdDNlbOuweQSdzYs2QW8PJVNxyumqtKvz2V3xPIQE9Gw==
X-Received: by 2002:aa7:86d7:0:b0:6da:8572:ecab with SMTP id h23-20020aa786d7000000b006da8572ecabmr587227pfo.64.1706252233040;
        Thu, 25 Jan 2024 22:57:13 -0800 (PST)
Received: from cuiyangpei ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id lp17-20020a056a003d5100b006ddd182bf1csm533350pfb.46.2024.01.25.22.57.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jan 2024 22:57:12 -0800 (PST)
Date: Fri, 26 Jan 2024 14:57:06 +0800
From: cuiyangpei <cuiyangpei@gmail.com>
To: SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: xiongping1@xiaom.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <20240126065706.GA16652@cuiyangpei>
References: <20240122054631.GA7880@cuiyangpei>
 <20240122175611.46371-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122175611.46371-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Jan 22, 2024 at 09:56:11AM -0800, SeongJae Park wrote:
> Hi cuiyangpei,
> 
> On Mon, 22 Jan 2024 13:46:31 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > On Sun, Dec 03, 2023 at 07:37:45PM +0000, SeongJae Park wrote:
> > > On 2023-12-03T13:43:13+08:00 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > 
> > > > On Fri, Dec 01, 2023 at 05:31:12PM +0000, SeongJae Park wrote:
> > > > > Hi Cuiyangpei,
> > > > > 
> > > > > On Fri, 1 Dec 2023 20:25:07 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > > > 
> > > > > > On Thu, Nov 30, 2023 at 07:44:20PM +0000, SeongJae Park wrote:
> > > > > > > Hi Cuiyangpei,
> > > > > > > 
> > > > > > > On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> [...]
> > 
> > Hi SeongJae,
> > 
> > We set 'access_pattern' and 'stat' action in schemes when apps are on
> > foreground, record apps' memory access pattern when they are switched
> > to the background with 'update_schemes_tried_regions' state. But it
> > catch the snapshot after next aggregation interval. DAMON is still
> > sampling during the app switches to the background and the next
> > aggregation time, which can cause the value of "age" to change. The
> > sampling results during this period cannot accurately reflect the app's
> > foreground access pattern.
> > 
> > Is there any way to catch sampling result immediately after setting the
> > "update_schemes_tried_regions" state?
> 
> There is no way for exactly doing this.  You would need to proactively collect
> snapshots while the app is foreground, and use the latest one that collected
> before the app goes background, like recording-based approach would do.
> 
> I think recent DAMON changes might make an alternative approach available,
> though.  From v6.7, DAMON provides pseudo-moving-average monitoring result in
> sampling interval granualrity, since patchset "mm/damon: provide pseudo-moving
> sum based access rate".  And a followup patchset, namely "mm/damon: implement
> DAMOS apply intervals", has made DAMOS works in the sampling interval
> granualrity.  Both patchsets are merged into v6.7-rc1.
> 
> Hence, I think you could use 'update_schemes_tried_regions' after you noticed
> the app's state transition, with DAMOS apply interval of one sampling interval.
> Then you will get the monitoring results after one sampling interval.  Of
> course, the snapshot may contain some of background access pattern, but
> wouldn't made it changed significantly, unless you set aggregation interval too
> short.

All other actions will apply at one sampling interval except for the
`stat` action.

We use 'update_schemes_tried_regions' after switch to the background. The 
before_damos_apply callback function will only be set when the next aggregation
interval arrives. The `tried_regions` will only be updated after setting the 
callback function. 

DAMON is still sampling during setting 'update_schemes_tried_regions' to the next
aggregation time, which is not what we expected. The pseudo-moving-average
monitoring result can reduce nr_accesees inaccuracy, but age is still being modified
during this time, so it can't improve this issue.

Please let me know if my understanding is incorrect. Thank you.
> 
> > Alternatively, can it return the "last_nr_accesses" and "last_age" values in
> > tried_regions/<N> directory?
> 
> This could also be a good alternative in my think.  Nice idea.  But, because
> the previously mentioned alternative is already available while this require a
> bit small but additional changes, could we check if the previously one make
> sense and works first?  We could revisit this idea if it turns out the previous
> alternative is not suffice in my opinion.
> 
Can you consider adding "last_nr_accesses" and "last_age"  two files in
'tried_regions/<N>' directory?

Thanks.
> > 
> > Do you have any other suggestions?
> 
> As I mentioned above, I'd suggest the DAMOS apply interval of single sampling
> interval for now.
> 
> 
> Thanks,
> SJ
> 
> > 
> > Thanks.
