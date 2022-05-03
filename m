Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94FF322E
	for <damon@lists.linux.dev>; Tue,  3 May 2022 15:52:51 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id k2so23981776wrd.5
        for <damon@lists.linux.dev>; Tue, 03 May 2022 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=contractor.linuxfoundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=LWHzgZGttdp/EiWVhAbA9Ae4j+ZyK0E3RqeOPUe7s/k=;
        b=mkRlTUV1W8Mb2lQKjzKVd7ZrG0AcTLAAjiSiPz4K0W8+uWqRP2g11LQXnn29GYlehN
         HEzlrNht+M+8i2B+BNcUzpX1vq1eL3chzu+azX0UrATluxhzBTTK9arcBC5uIeD0A3to
         8+DwEB9jak0oceaIGxMkdo3UF2e+p1jJBHxhYvZFlG2Qxqgbjk5NIhpR71rJcx+oiB9u
         qpZ9D9wTtZV95p5tyaiATxR4YaiaTELiRrNswgPSeeJR5yXcIJIXgwhuHopD2XdzgoLA
         rf4eE8Oa3cRkdifqv4mKMo4Pi8PiuTD+m6fDU/jbWvHA0VyOHdayoiX4gp6MtPlzqjSD
         vjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LWHzgZGttdp/EiWVhAbA9Ae4j+ZyK0E3RqeOPUe7s/k=;
        b=uoSACowyUqiUabklNgrl0DAO8kzLpoqGzloBArr7m++phBhttljHLtUaFHDo3etQlg
         nrWSguNo8Wtb6ulFBpAuPJ6J2sRVpFj4HaaeDvVbRS8CX6ll1HxEz8MnMOI7S6OAXCOZ
         rkbZN1BabQoRVfaDiJla4lVo9Flsjh5UfS3nK46svC+XBKbeWKwDD3bgtk+pEBVblq8M
         yaNRyjzzoywy7usJdxQN8eez6x6+Q6Rn9GbhChdA1hvwFtK2QMdI4Jvnyo51zB6/lj52
         ZCBF4lbU7z07xgEJi0yAuzJ6AJRHylOlJWZuoKQGzuSm9PyD7mVi4Me2gOJPDTENAL7Q
         sPBQ==
X-Gm-Message-State: AOAM533SYJB+jVgC+kj4fxZLF2//NLjH5eAmVQgBaXxfPenrqyq4SiYO
	JG3TFCnpu0lNJMCunW0W/nJuFX46z6YjGQ8W2IFS3NRPts7rZA==
X-Google-Smtp-Source: ABdhPJxL7mb2NnIvYKKvHxovE+RIzabu6OTSGsyscumMAiqcRMZ/J/4Z/6YrWt0dmDyXSQswTk+5dP8LYAkTApnTgU4=
X-Received: by 2002:a5d:5441:0:b0:20a:cdc0:6e90 with SMTP id
 w1-20020a5d5441000000b0020acdc06e90mr13380890wrv.566.1651593169752; Tue, 03
 May 2022 08:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Shyam Kumar <skachukattu@contractor.linuxfoundation.org>
Date: Tue, 3 May 2022 21:22:38 +0530
Message-ID: <CAH=dH9_QM7WwNJTP4JFBGJTxYJ1AZ-LARbbuQUrWgprx93RyYg@mail.gmail.com>
Subject: Test Mail for Damon
To: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello

This is a test message to test successful delivery and start the
 archive for the list. Please ignore.

-- 
Regards
Shyam Kumar
The Linux Foundation Core Projects
